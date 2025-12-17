// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sail_in_co/core/utils/connection_utils.dart';
import 'package:sail_in_co/core/utils/date_utils.dart';
import 'package:sail_in_co/data/dao/master/inventory_dao.dart';
import 'package:sail_in_co/data/dao/sales/outstanding_sales_order_dao.dart';
import 'package:sail_in_co/data/dao/sales/shipping_sales_order_dao.dart';
import 'package:sail_in_co/data/models/history/quick_sales_detail_response.dart';
import 'package:sail_in_co/data/models/history/sales_history_response_model.dart';
import 'package:sail_in_co/data/models/history/sales_order_detail_response_model.dart';
import 'package:sail_in_co/data/models/history/sales_order_request_model.dart';
import 'package:sail_in_co/data/models/history/sales_order_response_model.dart';
import 'package:sail_in_co/data/models/history/shipping_sales_order_payload.dart';
import 'package:sail_in_co/data/models/quicksales/quick_sales_response.dart' hide QuickSalesDetailModel;
import 'package:sail_in_co/data/repositories/sales_repository.dart';
import 'package:sail_in_co/services/auth_service.dart';
import 'package:sail_in_co/ui/widgets/app_snackbar.dart';

class SalesProvider extends ChangeNotifier {
  final repository = SalesRepository();
  final daoShippingSalesOrder = ShippingSalesOrderDao();
  final daoOutstandingSalesOrder = OutstandingSalesOrderDao();
  final daoInventory = InventoryItemDao();

  final TextEditingController searchController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  final TextEditingController historySearchController = TextEditingController();
  final TextEditingController historyStartDateController = TextEditingController();
  final TextEditingController historyEndDateController = TextEditingController();

  /// Pagination
  int page = 1;
  int limit = 100;
  int totalPages = 1;

  int historyPage = 1;
  int historyLimit = 100;
  int historyTotalPages = 1;

  /// States
  bool isLoading = false;
  bool isLoadMore = false;
  bool isLoadingDetail = false;
  bool isSubmitting = false;

  // Void
  bool isLoadingSalesOrderVoid = false;
  bool isLoadingQuickSalesVoid = false;

  bool isLoadingHistory = false;
  bool isLoadMoreHistory = false;
  bool isLoadingDetailHistory = false;
  bool isSubmittingHistory = false;

  DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime endDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59);

  DateTime historyStartDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime historyEndDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59);

  /// Data list
  SalesOrderResponseModel? salesOrderResponse;
  List<SalesOrderModel> dataSalesOrder = [];

  List<SalesHistoryItem> dataHistorySalesOrder = [];

  // Data Detail
  SalesOrderHeaderModel? salesOrderHeader;
  QuickSales? quickSalesDetail;

  int totalDiscount() {
    int total = 0;

    for (var item in salesOrderHeader?.details ?? []) {
      final int qty = int.tryParse(item.qty2) ?? 0;
      final int discount = int.tryParse(item.discValue ?? '0') ?? 0;
      total += discount * qty;
    }

    return total;
  }

  int subTotal() {
    int total = 0;

    for (var item in salesOrderHeader?.details ?? []) {
      final int qty = int.tryParse(item.qty) ?? 0;
      final int price = int.tryParse(item.price2 ?? '0') ?? 0;
      total += qty * price;
    }

    return total;
  }

  int grandTotal() {
    int total = 0;

    for (var item in salesOrderHeader?.details ?? []) {
      final int qty = int.tryParse(item.qty) ?? 0;
      final int qty2 = int.tryParse(item.qty2) ?? 0;
      final int price = int.tryParse(item.price2 ?? '0') ?? 0;
      final int discount = int.tryParse(item.discValue ?? '0') ?? 0;
      total += (qty * price) - (discount * qty2);
    }

    return total;
  }

  //quickSalesDetail
  int totalDiscountQuickSales() {
    int total = 0;

    for (var item in quickSalesDetail?.details ?? []) {
      final int qty = int.tryParse(item.qty2) ?? 0;
      final int discount = int.tryParse(item.discValue ?? '0') ?? 0;
      total += discount * qty;
    }

    return total;
  }

  int subTotalQuickSales() {
    int total = 0;

    for (var item in quickSalesDetail?.details ?? []) {
      final int qty = int.tryParse(item.qty) ?? 0;
      final int price = int.tryParse(item.price2 ?? '0') ?? 0;
      total += qty * price;
    }

    return total;
  }

  int grandTotalQuickSales() {
    int total = 0;

    for (var item in quickSalesDetail?.details ?? []) {
      final int qty = int.tryParse(item.qty) ?? 0;
      final int qty2 = int.tryParse(item.qty2) ?? 0;
      final int price = int.tryParse(item.price2 ?? '0') ?? 0;
      final int discount = int.tryParse(item.discValue ?? '0') ?? 0;
      total += (qty * price) - (discount * qty2);
    }

    return total;
  }

  // set start date
  void setStartDate(DateTime date) {
    startDate = date;
    startDateController.text = DateUtilsHelper.formatDMY(date);

    notifyListeners();
  }

  // set end date
  void setEndDate(DateTime date) {
    endDate = date;
    endDateController.text = DateUtilsHelper.formatDMY(date);
    notifyListeners();
  }

  void filterDate(String customerId) {
    page = 1;
    dataSalesOrder.clear();

    getOutstandingSalesOrders(initial: true, customerId: customerId);
    notifyListeners();
  }

  void setHistoryStartDate(DateTime date) {
    historyStartDate = date;
    historyStartDateController.text = DateUtilsHelper.formatDMY(date);

    notifyListeners();
  }

  void setHistoryEndDate(DateTime date) {
    historyEndDate = date;
    historyEndDateController.text = DateUtilsHelper.formatDMY(date);
    notifyListeners();
  }

  void filterHistoryDate(String customerId) {
    historyPage = 1;
    dataHistorySalesOrder.clear();

    getHistorySales(initial: true, customerId: customerId);
    notifyListeners();
  }

  // Get - List Outstanding Sales Orders
  Future<void> getOutstandingSalesOrders({bool loadMore = false, bool initial = false, required String customerId}) async {
    endDateController.text = DateUtilsHelper.formatDMY(endDate);
    startDateController.text = DateUtilsHelper.formatDMY(startDate);
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

  // Get - List History Sales
  Future<void> getHistorySales({bool loadMore = false, bool initial = false, required String customerId}) async {
    historyEndDateController.text = DateUtilsHelper.formatDMY(historyEndDate);
    historyStartDateController.text = DateUtilsHelper.formatDMY(historyStartDate);
    final userInfo = await AuthService.getUserInfo();
    final online = await ConnectionUtils.isConnected();
    if (online) {
      // LOAD MORE
      if (loadMore) {
        if (isLoadMoreHistory) return;
        if (historyPage >= historyTotalPages) return;

        isLoadMoreHistory = true;
        historyPage++;
        notifyListeners();
      } else if (initial) {
        isLoadingHistory = true;
        historyPage = 1;
        dataSalesOrder.clear();
        notifyListeners();
      }
      // INITIAL LOAD
      else {
        isLoadingHistory = true;
        historyPage = 1;
        dataSalesOrder.clear();
        notifyListeners();
      }
      final request = SalesOrderRequestModel(
        page: historyPage,
        limit: historyLimit,
        search: historySearchController.text,
        userId: userInfo?.userId ?? '',
        customerId: customerId,
        voidFlag: 0,
        status: 1,
        startDate: DateUtilsHelper.formatYMD(historyStartDate),
        endDate: DateUtilsHelper.formatYMD(historyEndDate),
      );

      final response = await repository.getSalesHistoryOrder(payload: request);

      final data = SalesHistoryResponseModel.fromJson(response.data);

      if (data.data.sales.isNotEmpty) {
        if (loadMore) {
          dataHistorySalesOrder.addAll(data.data.sales);
        } else {
          dataHistorySalesOrder = data.data.sales;
          historyTotalPages = data.data.pagination.totalPages;
        }
      }

      // END STATE
      if (loadMore) {
        isLoadMoreHistory = false;
      } else {
        isLoadingHistory = false;
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
          AppSnackBar.show(context, message: res.message ?? 'Unknown error', color: Colors.red);
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

  // Get - Quick Sales Order Detail
  Future<void> getQuickSalesOrder({required String quicSalesId, required BuildContext context}) async {
    isLoadingDetail = true;
    notifyListeners();
    final online = await ConnectionUtils.isConnected();
    try {
      if (online) {
        final res = await repository.getQuickSalesOrder(quicSalesId: quicSalesId);
        if (res.statusCode == 200 && res.data != null) {
          final dataDetail = QuickSalesDetailResponse.fromJson(res.data);
          quickSalesDetail = dataDetail.data.quickSales;
        } else {
          // Snackbar
          AppSnackBar.show(context, message: res.message ?? 'Unknown error', color: Colors.red);
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
          for (var item in salesOrderHeader?.details ?? []) {
            await daoInventory.reduceCurrentStock(inventoryId: item.inventoryId, qty: int.parse(item.qty2.toString()));
          }
          AppSnackBar.show(context, message: 'Berhasil mengirim shipping sales order.', color: Colors.green);
          Navigator.of(context).pop('refresh-shipping-order');
        } else {
          AppSnackBar.show(context, message: res.message ?? 'Unknown error', color: Colors.red);
        }
      } else {
        for (var item in salesOrderHeader?.details ?? []) {
          await daoInventory.reduceCurrentStock(inventoryId: item.inventoryId, qty: int.parse(item.qty2.toString()));
        }
        await daoShippingSalesOrder.saveShipping(payload);
        AppSnackBar.show(context, message: 'Shipping sales order disimpan secara offline.', color: Colors.green);
        Navigator.of(context).pop('refresh-shipping-order');
      }
    } catch (e) {
      AppSnackBar.show(context, message: 'Error posting shipping sales order: $e', color: Colors.red);
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }

  // Void - Sales Order
  Future<void> voidSalesOrder({required BuildContext context, required String salesOrderId, required String customerId}) async {
    final userInfo = await AuthService.getUserInfo();
    isLoadingSalesOrderVoid = true;
    notifyListeners();
    final online = await ConnectionUtils.isConnected();
    try {
      if (online) {
        final res = await repository.voidSalesOrder(transactionId: salesOrderId, userId: userInfo?.userId ?? '');
        if (res.statusCode == 200 && res.data != null) {
          AppSnackBar.show(context, message: 'Berhasil menghapus sales order.', color: Colors.green);
          getOutstandingSalesOrders(customerId: customerId);
          getHistorySales(customerId: customerId);
        } else {
          AppSnackBar.show(context, message: res.message ?? 'Unknown error', color: Colors.red);
        }
      } else {
        AppSnackBar.show(context, message: 'Tidak dapat membatalkan sales order secara offline.', color: Colors.red);
      }
    } catch (e) {
      AppSnackBar.show(context, message: 'Error voiding sales order: $e', color: Colors.red);
    } finally {
      isLoadingSalesOrderVoid = false;
      notifyListeners();
    }
  }

  // Void - Quick Sales
  Future<void> voidQuickSales({required BuildContext context, required String quickSalesId, required String customerId}) async {
    final userInfo = await AuthService.getUserInfo();
    isLoadingQuickSalesVoid = true;
    notifyListeners();
    final online = await ConnectionUtils.isConnected();
    try {
      if (online) {
        final res = await repository.voidQuickSales(transactionId: quickSalesId, userId: userInfo?.userId ?? '');
        if (res.statusCode == 200 && res.data != null) {
          AppSnackBar.show(context, message: 'Berhasil membatalkan quick sales.', color: Colors.green);
          getOutstandingSalesOrders(customerId: customerId);
          getHistorySales(customerId: customerId);
        } else {
          AppSnackBar.show(context, message: res.message ?? 'Unknown error', color: Colors.red);
        }
      } else {
        AppSnackBar.show(context, message: 'Tidak dapat membatalkan quick sales secara offline.', color: Colors.red);
      }
    } catch (e) {
      AppSnackBar.show(context, message: 'Error voiding quick sales: $e', color: Colors.red);
    } finally {
      isLoadingQuickSalesVoid = false;
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

  void searchHistorySalesOrders(String query, String customerId) {
    historySearchController.text = query;
    historyPage = 1;
    dataHistorySalesOrder.clear();

    getHistorySales(initial: true, customerId: customerId);
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
