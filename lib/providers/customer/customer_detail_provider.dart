import 'package:flutter/material.dart';
import 'package:sail_in_co/data/models/auth/auth_response_model.dart';
import 'package:sail_in_co/data/models/customer/customer_detail_response.dart';
import 'package:sail_in_co/data/repositories/customer_repository.dart';
import 'package:sail_in_co/services/auth_service.dart';

class CustomerDetailProvider extends ChangeNotifier {
  final _repo = CustomerRepository();

  bool isLoading = false;

  CustomerDetailData? customerDetailData;
  UserInfo? userInfo;

  Future<void> loadUserInfo() async {
    try {
      userInfo = await AuthService.getUserInfo();
    } catch (e) {
      debugPrint("Error loading user info: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> getDetailCustomer(String customerId, String scheduleId) async {
    isLoading = true;

    await Future.delayed(const Duration(milliseconds: 1000));
    notifyListeners();

    try {
      final res = await _repo.getCustomerDetail(customerId, scheduleId);
      customerDetailData = res?.data;
      print("Customer detail data loaded: ${customerDetailData?.toJson()}");
    } catch (e) {
      debugPrint("Error loading customer detail: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //onRefresh
  Future<void> onRefresh(String scheduleId) async {
    if (customerDetailData != null) {
      await getDetailCustomer(customerDetailData?.customer?.noAcc6 ?? '', scheduleId);
    }
  }

  void clear() {
    customerDetailData = null;
    isLoading = false;
    notifyListeners();
  }
}
