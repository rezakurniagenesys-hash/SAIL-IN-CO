// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sail_in_co/core/helpers/image_picker_helper.dart';
import 'package:sail_in_co/core/helpers/location_helper.dart';
import 'package:sail_in_co/core/utils/connection_utils.dart';
import 'package:sail_in_co/data/dao/callsheet/callsheet_customer_detail_dao.dart';
import 'package:sail_in_co/data/dao/callsheet/callsheet_customer_upload_foto_dao.dart';
import 'package:sail_in_co/data/models/auth/auth_response_model.dart';
import 'package:sail_in_co/data/models/customer/customer_detail_response.dart';
import 'package:sail_in_co/data/models/customer/upload_foto/customer_upload_foto_request.dart';
import 'package:sail_in_co/data/models/customer/upload_foto/customer_upload_foto_response.dart';
import 'package:sail_in_co/data/repositories/customer_repository.dart';
import 'package:sail_in_co/services/auth_service.dart';
import 'package:sail_in_co/ui/widgets/app_snackbar.dart';

class CustomerDetailProvider extends ChangeNotifier {
  final _repo = CustomerRepository();

  final daoCustomerDetail = CustomerDetailDao();
  final daoCustomerUploadFoto = CustomerUploadFotoDao();

  // ============= Customer Detail =============
  bool isLoading = false;
  bool isUploadingImage = false;
  CustomerDetailData? customerDetailData;
  CustomerModel? customerModel;
  UserInfo? userInfo;

  // ============= Upload Foto =============
  File? image;
  bool isLoadingLocation = true;
  bool isSubmitting = false;
  String address = '';
  String coords = '';
  String time = '';
  Timer? _timer;
  DateTime? _initialDateTime;
  Position? currentPosition;
  bool isStoreOpen = false;

  // =============== Methods Customer Detail ===============
  Future<void> loadUserInfo() async {
    try {
      userInfo = await AuthService.getUserInfo();
    } catch (e) {
      debugPrint("Error loading user info: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> getDetailCustomer(String customerId, String scheduleId, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final online = await ConnectionUtils.isConnected();
    try {
      if (online) {
        final res = await _repo.getCustomerDetail(customerId, scheduleId);
        if (res.statusCode == 200 && res.data != null) {
          customerDetailData = CustomerDetailResponse.fromJson(res.data).data;
        } else {
          // Snackbar
          AppSnackBar.show(context, message: res.message ?? 'Unknown error', color: Colors.red);
        }
      } else {
        customerModel = await daoCustomerDetail.getCustomerDetail(customerId);
        customerDetailData = CustomerDetailData(customer: customerModel);
        debugPrint("Customer detail loaded from SQLite (offline)");
      }
    } catch (e) {
      debugPrint("Error loading customer detail: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> onRefresh(String scheduleId, BuildContext context) async {
    if (customerDetailData != null) {
      await getDetailCustomer(customerDetailData?.customer?.noAcc6 ?? '', scheduleId, context);
    }
  }

  void setLoadingImage(bool value) {
    isUploadingImage = value;
    notifyListeners();
  }

  Future<bool> pickImage(BuildContext context) async {
    final picked = await ImagePickerHelper.pickFromCamera(context);
    if (picked != null) {
      image = picked;
      notifyListeners();
      return true;
    }
    return false;
  }

  // =============== Methods Upload Foto ===============
  void setLocation(String addr, String coord) {
    address = addr;
    coords = coord;
    notifyListeners();
  }

  void setLoadingLocation(bool value) {
    isLoadingLocation = value;
    notifyListeners();
  }

  // _initLocation
  Future<void> initLocation(BuildContext context) async {
    setLoadingLocation(true);

    Position? pos;

    final online = await ConnectionUtils.isConnected();

    if (online) {
      pos = await LocationHelper.getCurrentPositionWithPermissionFlow(context);
    } else {
      pos = await LocationHelper.getCurrentPositionOffline();
    }

    // final pos = await LocationHelper.getCurrentPositionWithPermissionFlow(context);
    if (!context.mounted) return;

    if (pos != null) {
      currentPosition = pos;
      final addr = await LocationHelper.latLongToAddress(pos.latitude, pos.longitude);

      setLocation(addr ?? 'Address not found', '${pos.latitude.toStringAsFixed(6)}, ${pos.longitude.toStringAsFixed(6)}');
    }

    setLoadingLocation(false);
  }

  void startDateTimeCounter(DateTime initialDateTime) {
    // stop timer lama kalau ada
    _timer?.cancel();

    _initialDateTime = initialDateTime;

    // set nilai awal
    time = _formatTime(initialDateTime);
    notifyListeners();

    // timer akurat berdasarkan waktu real
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_initialDateTime == null) return;

      final now = DateTime.now();
      final elapsed = now.difference(_initialDateTime!);
      final current = _initialDateTime!.add(elapsed);

      time = _formatTime(current);
      notifyListeners();
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  String _formatTime(DateTime dt) {
    final hh = dt.hour.toString().padLeft(2, '0');
    final mm = dt.minute.toString().padLeft(2, '0');
    final ss = dt.second.toString().padLeft(2, '0');
    return '$hh:$mm:$ss';
  }

  void setStoreOpen(bool value) {
    isStoreOpen = value;
    notifyListeners();
  }

  // Submit Foto
  Future<CustomerUploadFotoResponse?> submitPhoto(String customerId, String scheduleId, BuildContext context) async {
    if (image == null) return null;

    isSubmitting = true;
    notifyListeners();
    final online = await ConnectionUtils.isConnected();
    final req = CustomerUploadFotoRequest(
      address: address,
      latitude: currentPosition!.latitude.toString(),
      longitude: currentPosition!.longitude.toString(),
      statusVisit: isStoreOpen ? 2 : 1,
      userModified: userInfo?.username ?? '',
      visitDate: DateTime.now(),
    );

    try {
      if (online) {
        // Jika lokasi belum ada → init dulu
        if (currentPosition == null) {
          await initLocation(context);
        }

        // Setelah init, cek lagi
        if (currentPosition == null) {
          // lokasi tetap tidak didapat → batal submit
          isSubmitting = false;
          notifyListeners();
          debugPrint("Submit dibatalkan karena lokasi tidak tersedia.");
          return null;
        }
        // Upload foto ke server
        final res = await _repo.updateCustomerPhoto(customerId, scheduleId, image!, req);

        if (res.status == true) {
          debugPrint("Customer photo uploaded successfully: ${res.toJson()}");
        }

        return res;
      } else {
        await daoCustomerUploadFoto.save(payload: req, imageBase64: ImagePickerHelper.convertFileToBase64(image!));
        CustomerUploadFotoResponse dataUpload = CustomerUploadFotoResponse(
          status: false,
          message: '',
          data: CustomerUploadFotoData(
            filename: '',
            originalName: '',
            size: 0,
            url: '',
            fullUrl: '',
            scheduleId: scheduleId,
            customerId: customerId,
            latitude: currentPosition?.latitude.toString() ?? '',
            longitude: currentPosition?.longitude.toString() ?? '',
            address: address,
            statusVisit: isStoreOpen ? 2 : 1,
            linkPathUpdated: false,
          ),
        );
        final response = dataUpload.copyWith(status: true, message: 'Berhasil upload foto customer secara lokal.');
        return response;
      }
    } catch (e) {
      debugPrint("Error submitting customer photo: $e");
      return null;
    } finally {
      // Set submitting false di satu tempat saja
      isSubmitting = false;
      notifyListeners();
    }
  }

  void clear() {
    customerDetailData = null;
    isLoading = false;
    notifyListeners();
  }

  // Jump
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  /// Set tab manual
  void setTab(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    notifyListeners();
  }
}
