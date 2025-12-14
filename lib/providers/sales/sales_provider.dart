// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sail_in_co/core/utils/connection_utils.dart';
import 'package:sail_in_co/core/utils/date_utils.dart';
import 'package:sail_in_co/data/dao/sales/outstanding_sales_order_dao.dart';
import 'package:sail_in_co/data/dao/sales/shipping_sales_order_dao.dart';
import 'package:sail_in_co/data/models/history/sales_order_detail_response_model.dart';
import 'package:sail_in_co/data/models/history/sales_order_request_model.dart';
import 'package:sail_in_co/data/models/history/sales_order_response_model.dart';
import 'package:sail_in_co/data/models/history/shipping_sales_order_payload.dart';
import 'package:sail_in_co/data/repositories/sales_repository.dart';
import 'package:sail_in_co/services/auth_service.dart';

class SalesProvider extends ChangeNotifier {
  final repository = SalesRepository();
  final daoShippingSalesOrder = ShippingSalesOrderDao();
  final daoOutstandingSalesOrder = OutstandingSalesOrderDao();

  final TextEditingController searchController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  /// Pagination
  int page = 1;
  int limit = 100;
  int totalPages = 1;

  /// States
  bool isLoading = false;
  bool isLoadMore = false;
  bool isLoadingDetail = false;
  bool isSubmitting = false;

  DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime endDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59);

  /// Data list
  SalesOrderResponseModel? salesOrderResponse;
  List<SalesOrderModel> dataSalesOrder = [];

  // Data Detail
  SalesOrderHeaderModel? salesOrderHeader;

  int totalDiscount() {
    int total = 0;

    for (var item in salesOrderHeader?.details ?? []) {
      // final int qty = int.tryParse(item.qty2) ?? 0;
      final int discount = int.tryParse(item.discValue ?? '0') ?? 0;
      total += discount;
    }

    return total;
  }

  int subTotal() {
    int total = 0;

    for (var item in salesOrderHeader?.details ?? []) {
      final int qty = int.tryParse(item.qty) ?? 0;
      final int price = int.tryParse(item.price ?? '0') ?? 0;
      total += qty * price;
    }

    return total;
  }

  int grandTotal() {
    int total = 0;

    for (var item in salesOrderHeader?.details ?? []) {
      final int qty = int.tryParse(item.qty) ?? 0;
      final int price = int.tryParse(item.price ?? '0') ?? 0;
      final int discount = int.tryParse(item.discValue ?? '0') ?? 0;
      total += (qty * price) - (qty * discount);
    }

    return total;
  }

  // set start date
  void setStartDate(DateTime date) {
    startDate = date;
    startDateController.text = DateUtilsHelper.formatYMD(date);

    notifyListeners();
  }

  // set end date
  void setEndDate(DateTime date) {
    endDate = date;
    endDateController.text = DateUtilsHelper.formatYMD(date);
    notifyListeners();
  }

  void filterDate(String customerId) {
    page = 1;
    dataSalesOrder.clear();

    getOutstandingSalesOrders(initial: true, customerId: customerId);
    notifyListeners();
  }

  // Get - List Outstanding Sales Orders
  Future<void> getOutstandingSalesOrders({bool loadMore = false, bool initial = false, required String customerId}) async {
    endDateController.text = DateUtilsHelper.formatYMD(endDate);
    startDateController.text = DateUtilsHelper.formatYMD(startDate);
    final userInfo = await AuthService.getUserInfo();
    final online = await ConnectionUtils.isConnected();
    if (online) {
      // LOAD MORE
      if (loadMore) {
        if (isLoadMore) return;
        if (page >= totalPages) return;

        isLoadMore = true;
        page++;
        notifyListeners();
      } else if (initial) {
        isLoading = true;
        page = 1;
        dataSalesOrder.clear();
        notifyListeners();
      }
      // INITIAL LOAD
      else {
        isLoading = true;
        page = 1;
        dataSalesOrder.clear();
        notifyListeners();
      }
      final request = SalesOrderRequestModel(
        page: page,
        limit: limit,
        search: searchController.text,
        userId: userInfo?.userId ?? '',
        customerId: customerId,
        voidFlag: 0,
        status: 1,
        startDate: DateUtilsHelper.formatYMD(startDate),
        endDate: DateUtilsHelper.formatYMD(endDate),
      );

      final response = await repository.getOutstandingSalesOrders(payload: request);

      final data = SalesOrderResponseModel.fromJson(response.data);

      if (data.data.data.isNotEmpty) {
        if (loadMore) {
          dataSalesOrder.addAll(data.data.data);
        } else {
          dataSalesOrder = data.data.data;
          totalPages = data.data.totalPages;
        }
      }

      // END STATE
      if (loadMore) {
        isLoadMore = false;
      } else {
        isLoading = false;
      }
    } else {
      await daoOutstandingSalesOrder.getByCustomerId(customerId: customerId, search: searchController.text).then((value) {
        dataSalesOrder = value;
      });
    }

    notifyListeners();
  }

  // Get - Detail Outstanding Sales Orders
  Future<void> getDetailOutstandingSalesOrders({required String salesOrderId, required BuildContext context}) async {
    isLoadingDetail = true;
    notifyListeners();
    final online = await ConnectionUtils.isConnected();
    try {
      if (online) {
        final res = await repository.getDetailOutstandingSalesOrders(salesOrderId: salesOrderId);
        if (res.statusCode == 200 && res.data != null) {
          final dataDetail = SalesOrderDetailResponseModel.fromJson(res.data);
          salesOrderHeader = dataDetail.data;
        } else {
          // Snackbar
          SnackBar snackBar = SnackBar(content: Text(res.message ?? 'Unknown error'), backgroundColor: Colors.red);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        // customerModel = await daoCustomerDetail.getCustomerDetail(customerId);
        // customerDetailData = CustomerDetailData(customer: customerModel);
        debugPrint("Outstanding Order loaded from SQLite (offline)");
      }
    } catch (e) {
      debugPrint("Error loading customer detail: $e");
    } finally {
      isLoadingDetail = false;
      notifyListeners();
    }
  }

  // Post - Shipping for Sales Order
  Future<void> postShippingForSalesOrder({required BuildContext context, required String salesOrderId}) async {
    final userInfo = await AuthService.getUserInfo();
    isSubmitting = true;
    notifyListeners();
    final online = await ConnectionUtils.isConnected();
    final payload = ShippingSalesOrderPayload(salesOrderId: salesOrderId, userRecord: userInfo?.username ?? '');
    try {
      if (online) {
        final res = await repository.postShippingForSalesOrder(payload: payload);
        if (res.statusCode == 201 && res.data != null) {
          SnackBar snackBar = const SnackBar(content: Text('Berhasil mengirim shipping sales order.'), backgroundColor: Colors.green);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.of(context).pop('refresh-shipping-order');
        } else {
          SnackBar snackBar = SnackBar(content: Text(res.message ?? 'Unknown error'), backgroundColor: Colors.red);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        await daoShippingSalesOrder.saveShipping(payload);
        SnackBar snackBar = const SnackBar(content: Text('Shipping sales order disimpan secara offline.'), backgroundColor: Colors.green);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).pop('refresh-shipping-order');
      }
    } catch (e) {
      SnackBar snackBar = SnackBar(content: Text('Error posting shipping sales order: $e'), backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }

  void searchOutstandingSalesOrders(String query, String customerId) {
    searchController.text = query;
    page = 1;
    dataSalesOrder.clear();

    getOutstandingSalesOrders(initial: true, customerId: customerId);
    notifyListeners();
  }

  void clearData() {
    page = 1;
    totalPages = 1;
    isLoading = false;
    isLoadMore = false;
    isLoadingDetail = false;
    searchController.clear();
    notifyListeners();
  }
}
