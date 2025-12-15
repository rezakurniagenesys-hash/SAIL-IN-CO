import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sail_in_co/core/constants/constant_date.dart';
import 'package:sail_in_co/core/utils/connection_utils.dart';
import 'package:sail_in_co/core/utils/date_utils.dart';
import 'package:sail_in_co/data/dao/activity/activity_history_transaction_dao.dart';
import 'package:sail_in_co/data/dao/callsheet/callsheet_customer_detail_dao.dart';
import 'package:sail_in_co/data/dao/callsheet/callsheet_customer_item_dao.dart';
import 'package:sail_in_co/data/dao/callsheet/callsheet_summary_dao.dart';
import 'package:sail_in_co/data/dao/master/inventory_dao.dart';
import 'package:sail_in_co/data/dao/master/method_payment_dao.dart';
import 'package:sail_in_co/data/dao/pattycash/pattycash_dao.dart';
import 'package:sail_in_co/data/dao/sales/outstanding_payment_dao.dart';
import 'package:sail_in_co/data/dao/sales/outstanding_sales_order_dao.dart';
import 'package:sail_in_co/data/dao/sales/quick_sales_dao.dart';
import 'package:sail_in_co/data/dao/sales/sales_order_dao.dart';
import 'package:sail_in_co/data/dao/sales/sales_return_dao.dart';
import 'package:sail_in_co/data/dao/sales/shipping_sales_order_dao.dart';
import 'package:sail_in_co/data/dao/stock/stock_item_dao.dart';
import 'package:sail_in_co/data/models/customer/customer_detail_response.dart';
import 'package:sail_in_co/data/models/customer/customer_search_request.dart';
import 'package:sail_in_co/data/models/general/general_inventory/general_inventory_request.dart';
import 'package:sail_in_co/data/models/general/general_inventory/general_inventory_response.dart';
import 'package:sail_in_co/data/models/history/activity_history_response_model.dart';
import 'package:sail_in_co/data/models/history/history_transaction_payload_model.dart';
import 'package:sail_in_co/data/models/history/sales_order_request_model.dart';
import 'package:sail_in_co/data/models/history/sales_order_response_model.dart';
import 'package:sail_in_co/data/models/history/shipping_sales_order_payload.dart';
import 'package:sail_in_co/data/models/payment/payment_method_response.dart';
import 'package:sail_in_co/data/models/quicksales/outstanding_payment_payload_model.dart';
import 'package:sail_in_co/data/models/quicksales/quick_sales_detail_model.dart';
import 'package:sail_in_co/data/models/quicksales/quick_sales_payload_model.dart';
import 'package:sail_in_co/data/models/salesorder/sales_order_detail.dart';
import 'package:sail_in_co/data/models/salesorder/sales_order_payload_model.dart';
import 'package:sail_in_co/data/models/salesorder/sales_return_payment_payload.dart';
import 'package:sail_in_co/data/models/stock/stock_request.dart';
import 'package:sail_in_co/data/models/stock/stock_response.dart';
import 'package:sail_in_co/data/models/summary/callsheet_summary_response.dart';
import 'package:sail_in_co/data/models/summary/summary_request.dart';
import 'package:sail_in_co/data/repositories/activity_repository.dart';
import 'package:sail_in_co/data/repositories/customer_repository.dart';
import 'package:sail_in_co/data/repositories/generals_repository.dart';
import 'package:sail_in_co/data/repositories/home_repository.dart';
import 'package:sail_in_co/data/repositories/payment_repository.dart';
import 'package:sail_in_co/data/repositories/sales_repository.dart';
import 'package:sail_in_co/data/repositories/stock_repository.dart';
import 'package:sail_in_co/services/auth_service.dart';

class SyncProvider extends ChangeNotifier {
  final repoHome = HomeRepository();
  final repoStock = StockRepository();
  final repoGenerals = GeneralsRepository();
  final repoCustomer = CustomerRepository();
  final repoPayment = PaymentRepository();
  final repoSales = SalesRepository();
  final repoActivityHistory = ActivityRepository();

  final daoCallSheet = CallsheetSummaryDao();
  final daoStock = StockItemDao();
  final daoInventory = InventoryItemDao();
  final daoCallsheetCustomer = CallsheetCustomerItemDao();
  final daoMethodPayment = MethodPaymentDao();
  final daoCustomerDetail = CustomerDetailDao();
  final daoActivityHistory = ActivityHistoryTransactionDao();
  final daoPattycashDao = PattycashDao();
  final daoOutstandingSalesOrder = OutstandingSalesOrderDao();
  // Sales Dao
  final daoQuickSales = QuickSalesDao();
  final daoSalesOrder = SalesOrderDao();
  final daoSalesReturn = SalesReturnDao();
  final daoShippingSalesOrder = ShippingSalesOrderDao();
  final daoOutstandingPayment = OutstandingPaymentDao();

  final date = ConstantDate.date;
  DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime endDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59);

  // SYNC STATE
  bool isSyncing = false;
  int totalPending = 0;
  int syncedCount = 0;
  String? lastError;

  /// Initialize Sync
  Future<void> init({required VoidCallback onShowLoading, required VoidCallback onHideLoading}) async {
    final online = await ConnectionUtils.isConnected();
    if (!online) return;
    onShowLoading();

    // HomeScreen Sync
    await getSummaryChart();
    await getStock();

    // Master Data Sync
    await getInventory();
    await getPaymentMethod();

    // Finish Task Sync
    await getCallsheetCustomerItems();
    await syncAllCustomerDetails();
    await syncAllActivityHistory();
    await syncAllOutstandingSalesOrders();

    await syncLocalQuickSales();
    await syncLocalSalesOrder();
    await syncLocalSalesReturn();
    await syncLocalShippingSalesOrder();
    await syncLocalOutstandingPayment();

    onHideLoading();
  }

  // ============================
  // CALLSHEET SUMMARY SYNC
  // ============================
  Future<void> getSummaryChart() async {
    final userInfo = await AuthService.getUserInfo();

    final request = SummaryRequest(date: DateUtilsHelper.formatYMD(date), salesId: userInfo?.username ?? '');

    final res = await repoHome.getSummaryChart(request);

    if (res.statusCode == 200 && res.data != null) {
      final summaryResponse = CallsheetSummaryResponse.fromJson(res.data).data;

      await daoCallSheet.saveSummary(
        SummaryData(pendingTasks: summaryResponse?.pendingTasks, completedTasks: summaryResponse?.completedTasks, totalTasks: summaryResponse?.totalTasks),
      );

      notifyListeners();
    }
  }

  // ============================
  // STOCK SYNC
  // ============================
  Future<void> getStock() async {
    final userInfo = await AuthService.getUserInfo();

    final stockRequest = StockRequest(warehouseId: userInfo?.userId ?? '', date: DateUtilsHelper.formatYMD(date));

    final res = await repoStock.getStock(stockRequest: stockRequest);

    if (res.statusCode == 200 && res.data != null) {
      final stockList = StockResponse.fromJson(res.data).data?.stock ?? [];
      await daoStock.saveStockItems(stockList);
    }

    notifyListeners();
  }

  // ============================
  // INVENTORY SYNC
  // ============================
  Future<void> getInventory() async {
    final userInfo = await AuthService.getUserInfo();
    final inventoryRequest = GeneralInventoryRequest(page: 1, limit: 100, warehouseId: userInfo?.username, date: DateUtilsHelper.formatYMD(date));
    final res = await repoGenerals.getGeneralInventory(generalInventoryRequest: inventoryRequest);

    if (res.statusCode == 200 && res.data != null) {
      final inventorys = GeneralInventoryResponse.fromJson(res.data).data.inventoryData;
      await daoInventory.saveInventoryItems(inventorys);
    }

    notifyListeners();
  }

  // ============================
  // CALLSHEET CUSTOMER ITEM SYNC
  // ============================
  Future<void> getCallsheetCustomerItems() async {
    final userInfo = await AuthService.getUserInfo();
    final request = CustomerSearchRequest(page: 1, limit: 100, salesId: userInfo?.username, date: DateUtilsHelper.formatYMD(date));
    final response = await repoCustomer.getCustomerManagement(request);

    if (response?.data?.customerData != null) {
      final customers = response?.data?.customerData ?? [];
      await daoCallsheetCustomer.saveCustomers(customers);
    }

    notifyListeners();
  }

  // ============================
  //  PAYMENT METHOD SYNC
  // ============================
  Future<void> getPaymentMethod() async {
    final userInfo = await AuthService.getUserInfo();

    final res = await repoPayment.getPaymentMethods(noAcc6: userInfo?.userId ?? '');
    if (res.statusCode == 200 && res.data != null) {
      final responsePaymentMethod = PaymentMethodResponse.fromJson(res.data);
      final paymentMethodData = responsePaymentMethod.data;
      await daoMethodPayment.savePaymentMethods(paymentMethodData);
    }
    notifyListeners();
  }

  /// ============================
  /// Fetch Detail Customer untuk seluruh list callsheet
  /// ============================
  Future<void> syncAllCustomerDetails() async {
    final customerList = await daoCallsheetCustomer.getCustomers();
    await daoCustomerDetail.deleteAllCustomerDetails();

    for (var item in customerList) {
      try {
        final res = await repoCustomer.getCustomerDetail(item.noAcc6 ?? "", item.scheduleId ?? "");

        if (res.statusCode == 200 && res.data != null) {
          final detail = CustomerDetailResponse.fromJson(res.data).data?.customer;

          if (detail != null) {
            await daoCustomerDetail.saveCustomerDetail(detail);
          }
        }
      } catch (e) {
        debugPrint("Failed to sync detail for ${item.noAcc6}: $e");
      }
    }

    debugPrint("✅ Kurnia Sync Detail Customer Selesai (${customerList.length} customer)");
    notifyListeners();
  }

  /// ============================
  /// Fetch Activity History untuk seluruh list callsheet
  /// ============================
  Future<void> syncAllActivityHistory() async {
    final userInfo = await AuthService.getUserInfo();
    final customerList = await daoCallsheetCustomer.getCustomers();
    await daoActivityHistory.clearAll();

    for (var item in customerList) {
      try {
        final request = HistoryTransactionPayloadModel(
          userId: userInfo?.userId ?? '',
          customerId: item.noAcc6 ?? '',
          startDate: DateUtilsHelper.formatYMD(startDate),
          endDate: DateUtilsHelper.formatYMD(endDate),
          page: 1,
          limit: 100,
        );

        final res = await repoActivityHistory.getActivityHistory(payload: request);

        if (res.statusCode == 200 && res.data != null) {
          final dataList = ActivityHistoryResponseModel.fromJson(res.data).data.transactions;

          if (dataList.isNotEmpty) {
            await daoActivityHistory.insertAll(customerId: item.noAcc6 ?? "", items: dataList);
          }
        }
      } catch (e) {
        debugPrint("Failed to sync activity history for ${item.noAcc6}: $e");
      }
    }

    debugPrint("✅ Kurnia Sync Activity History Selesai (${customerList.length} customer)");
    notifyListeners();
  }

  /// ============================
  /// Fetch Activity History untuk seluruh list callsheet
  /// ============================
  Future<void> syncAllOutstandingSalesOrders() async {
    final userInfo = await AuthService.getUserInfo();
    final customerList = await daoCallsheetCustomer.getCustomers();
    await daoOutstandingSalesOrder.clearAll();

    for (var item in customerList) {
      try {
        final request = SalesOrderRequestModel(
          userId: userInfo?.userId ?? '',
          startDate: DateUtilsHelper.formatYMD(startDate),
          endDate: DateUtilsHelper.formatYMD(endDate),
          page: 1,
          limit: 100,
          customerId: item.noAcc6 ?? '',
          voidFlag: 0,
          status: 1,
        );

        final res = await repoSales.getOutstandingSalesOrders(payload: request);

        if (res.statusCode == 200 && res.data != null) {
          final dataList = SalesOrderResponseModel.fromJson(res.data).data.data;

          if (dataList.isNotEmpty) {
            await daoOutstandingSalesOrder.insertAll(items: dataList);
          }
        }
      } catch (e) {
        debugPrint("Failed to sync activity history for ${item.noAcc6}: $e");
      }
    }

    debugPrint("✅ Kurnia Sync Outstanding Sales Order Selesai (${customerList.length} customer)");
    notifyListeners();
  }

  /// ============================
  /// PATTY CASH SYNC
  /// ============================
  ///
  Future<void> getPattycash() async {
    final userInfo = await AuthService.getUserInfo();

    final online = await ConnectionUtils.isConnected();

    if (online) {
      final res = await repoHome.getPattyCash(userId: userInfo?.userId ?? '');
      if (res.statusCode == 201 && res.data != null) {
        final data = res.data;
        await daoPattycashDao.savePattyCash(data['sisaSaldo'] ?? 0);
      }
    }
  }

  /// ============================
  /// Sync Semua Quick Sales Local
  /// ============================
  Future<void> syncLocalQuickSales() async {
    if (isSyncing) return;

    isSyncing = true;
    syncedCount = 0;
    lastError = null;
    notifyListeners();

    try {
      final pendingRows = await daoQuickSales.getPendingSalesOrder();
      totalPending = pendingRows.length;
      notifyListeners();

      for (final row in pendingRows) {
        final localId = row['local_id'] as int;

        try {
          // ===============================
          // DECODE DETAIL JSON
          // ===============================
          final List<QuickSalesDetailModel> details = (jsonDecode(row['details_json']) as List).map((e) => QuickSalesDetailModel.fromJson(e)).toList();

          // ===============================
          // BUILD MODEL (FULLY TYPED)
          // ===============================
          final payload = QuickSalesPayloadModel(
            quickSalesDate: row['quick_sales_date'],
            customerId: row['customer_id'],
            areaId: row['area_id'],
            salesId: row['sales_id'],
            paymentType: row['payment_type'],
            sourceId: row['source_id'],
            warehouseId: row['warehouse_id'],
            currencyId: row['currency_id'],
            rate: row['rate'],
            subTotal: row['sub_total'],
            discount: row['discount'],
            total: row['total'],
            grandTotal: row['grand_total'],
            slipId: row['slip_id'],
            salesReturnId: row['sales_return_id'],
            salesReturnPayment: row['sales_return_payment'],
            remainingPayment: row['remaining_payment'],
            notes: row['notes'],
            isVoid: row['is_void'],
            status: row['status'],
            destinationAddress: row['destination_address'],
            salesType: row['sales_type'],
            userRecord: row['user_record'],
            details: details,
          );

          // ===============================
          // POST KE SERVER
          // ===============================
          final res = await repoPayment.postQuickSales(payload: payload);

          if (res.statusCode == 201 && res.data != null) {
            // ✅ SUKSES → HAPUS DATA LOKAL
            await daoQuickSales.deleteAfterSyncSuccess(localId);
            syncedCount++;
            notifyListeners();
          } else {
            // ❌ API ERROR
            await daoQuickSales.markSyncError(localId, res.message ?? 'Sync failed (${res.statusCode})');
          }
        } catch (e) {
          // ❌ NETWORK / PARSE ERROR
          await daoQuickSales.markSyncError(localId, e.toString());
        }
      }
    } finally {
      isSyncing = false;
      notifyListeners();
    }
  }

  /// ============================
  /// Sync Semua Sales Order Local
  /// ============================
  Future<void> syncLocalSalesOrder() async {
    if (isSyncing) return;

    isSyncing = true;
    syncedCount = 0;
    lastError = null;
    notifyListeners();

    print("Starting syncLocalSalesOrder...");

    try {
      final pendingRows = await daoSalesOrder.getPendingSalesOrders();
      totalPending = pendingRows.length;
      notifyListeners();

      for (final row in pendingRows) {
        final localId = row['local_id'] as int;
        print("XIXIXI Processing Sales Order with local_id: $localId");
        try {
          // ===============================
          // DECODE DETAIL JSON
          // ===============================
          final List<SalesOrderDetail> details = (jsonDecode(row['details_json']) as List).map((e) => SalesOrderDetail.fromJson(e)).toList();

          // ===============================
          // BUILD MODEL (FULLY TYPED)
          // ===============================
          final payload = SalesOrderPayloadModel(
            salesOrderDate: row['sales_order_date'],
            customerId: row['customer_id'],
            areaId: row['area_id'],
            salesId: row['sales_id'],
            paymentType: row['payment_type'],
            sourceId: row['source_id'],
            warehouseId: row['warehouse_id'],
            currencyId: row['currency_id'],
            rate: row['rate'],
            subTotal: row['sub_total'],
            discount: row['discount'],
            total: row['total'],
            grandTotal: row['grand_total'],
            // slipId: row['slip_id'],
            // salesReturnId: row['sales_return_id'],
            // salesReturnPayment: row['sales_return_payment'],
            // remainingPayment: row['remaining_payment'],
            notes: row['notes'],
            isVoid: row['is_void'],
            status: row['status'],
            destinationAddress: row['destination_address'],
            salesType: row['sales_type'],
            userRecord: row['user_record'],
            details: details,
          );

          // ===============================
          // POST KE SERVER
          // ===============================
          final res = await repoSales.postSalesOrder(payload: payload);

          if (res.statusCode == 201 && res.data != null) {
            // ✅ SUKSES → HAPUS DATA LOKAL
            await daoSalesOrder.deleteAfterSyncSuccess(localId);
            syncedCount++;
            notifyListeners();
            print("XIXIXI Successfully synced Sales Order with local_id: $localId");
          } else {
            // ❌ API ERROR
            await daoSalesOrder.markSyncError(localId, res.message ?? 'Sync failed (${res.statusCode})');
            print("XIXIXI Failed to sync Sales Order with local_id: $localId. Error: ${res.message}");
          }
        } catch (e) {
          // ❌ NETWORK / PARSE ERROR
          await daoSalesOrder.markSyncError(localId, e.toString());
          print("XIXIXI Exception while syncing Sales Order with local_id: $localId. Exception: $e");
        }
      }
    } finally {
      isSyncing = false;
      notifyListeners();
    }
  }

  /// ============================
  /// Sync Semua Sales Return Local
  /// ============================
  Future<void> syncLocalSalesReturn() async {
    if (isSyncing) return;

    isSyncing = true;
    syncedCount = 0;
    lastError = null;
    notifyListeners();

    try {
      final pendingRows = await daoSalesReturn.getPendingSalesReturn();
      totalPending = pendingRows.length;
      notifyListeners();

      for (final row in pendingRows) {
        final localId = row['local_id'] as int;
        try {
          // ===============================
          // DECODE DETAIL JSON
          // ===============================
          final List<SalesOrderDetail> details = (jsonDecode(row['details_json']) as List).map((e) => SalesOrderDetail.fromJson(e)).toList();

          // ===============================
          // BUILD MODEL (FULLY TYPED)
          // ===============================
          final payload = SalesReturnPaymentPayload(
            salesReturnDate: row['sales_return_date'],
            customerId: row['customer_id'],
            areaId: row['area_id'],
            salesId: row['sales_id'],
            paymentType: row['payment_type'],
            sourceId: row['source_id'],
            warehouseId: row['warehouse_id'],
            currencyId: row['currency_id'],
            rate: row['rate'],
            subTotal: row['sub_total'],
            discount: row['discount'],
            total: row['total'],
            grandTotal: row['grand_total'],
            // slipId: row['slip_id'],
            // salesReturnId: row['sales_return_id'],
            // salesReturnPayment: row['sales_return_payment'],
            // remainingPayment: row['remaining_payment'],
            notes: row['notes'],
            isVoid: row['is_void'],
            status: row['status'],
            destinationAddress: row['destination_address'],
            salesType: row['sales_type'],
            userRecord: row['user_record'],
            details: details,
          );

          // ===============================
          // POST KE SERVER
          // ===============================
          final res = await repoSales.potstSalesReturn(payload: payload);

          if (res.statusCode == 201 && res.data != null) {
            // ✅ SUKSES → HAPUS DATA LOKAL
            await daoSalesReturn.deleteAfterSyncSuccess(localId);
            syncedCount++;
            notifyListeners();
          } else {
            // ❌ API ERROR
            await daoSalesReturn.markSyncError(localId, res.message ?? 'Sync failed (${res.statusCode})');
          }
        } catch (e) {
          // ❌ NETWORK / PARSE ERROR
          await daoSalesReturn.markSyncError(localId, e.toString());
        }
      }
    } finally {
      isSyncing = false;
      notifyListeners();
    }
  }

  /// ============================
  /// Sync Semua Shipping Sales Order Local
  /// ============================
  Future<void> syncLocalShippingSalesOrder() async {
    if (isSyncing) return;

    isSyncing = true;
    syncedCount = 0;
    lastError = null;
    notifyListeners();

    try {
      final pendingRows = await daoShippingSalesOrder.getPendingShipping();
      totalPending = pendingRows.length;
      notifyListeners();

      for (final row in pendingRows) {
        final localId = row['local_id'] as int;
        try {
          // ===============================
          // BUILD MODEL (FULLY TYPED)
          // ===============================
          final payload = ShippingSalesOrderPayload(salesOrderId: row['sales_order_id'], userRecord: row['user_record']);

          // ===============================
          // POST KE SERVER
          // ===============================
          final res = await repoSales.postShippingForSalesOrder(payload: payload);

          if (res.statusCode == 201 && res.data != null) {
            // ✅ SUKSES → HAPUS DATA LOKAL
            await daoShippingSalesOrder.deleteAfterSyncSuccess(localId);
            syncedCount++;
            notifyListeners();
          } else {
            // ❌ API ERROR
            await daoShippingSalesOrder.markSyncError(localId, res.message ?? 'Sync failed (${res.statusCode})');
          }
        } catch (e) {
          // ❌ NETWORK / PARSE ERROR
          await daoShippingSalesOrder.markSyncError(localId, e.toString());
        }
      }
    } finally {
      isSyncing = false;
      notifyListeners();
    }
  }

  /// ============================
  /// Sync Semua Outstanding Payment Local
  /// ============================
  Future<void> syncLocalOutstandingPayment() async {
    if (isSyncing) return;

    isSyncing = true;
    syncedCount = 0;
    lastError = null;
    notifyListeners();

    try {
      final pendingRows = await daoOutstandingPayment.getPendingOutstandingPayments();
      totalPending = pendingRows.length;
      notifyListeners();

      for (final row in pendingRows) {
        final localId = row['local_id'] as int;
        try {
          // ===============================
          // BUILD MODEL (FULLY TYPED)
          // ===============================
          final payload = OutstandingPaymentPayloadModel(
            invoiceId: row['invoice_id'],
            slipId: row['slip_id'],
            salesReturnId: row['sales_return_id'] ?? '',
            salesReturnPayment: row['sales_return_payment'],
            remainingPayment: row['remaining_payment'],
            userRecord: row['user_record'],
          );

          // ===============================
          // POST KE SERVER
          // ===============================
          final res = await repoPayment.postInvoicePaymentJournal(payload: payload);

          if (res.statusCode == 201 && res.data != null) {
            // ✅ SUKSES → HAPUS DATA LOKAL
            await daoOutstandingPayment.deleteAfterSyncSuccess(localId);
            syncedCount++;
            notifyListeners();
          } else {
            // ❌ API ERROR
            await daoOutstandingPayment.markSyncError(localId, res.message ?? 'Sync failed (${res.statusCode})');
          }
        } catch (e) {
          // ❌ NETWORK / PARSE ERROR
          await daoOutstandingPayment.markSyncError(localId, e.toString());
        }
      }
    } finally {
      isSyncing = false;
      notifyListeners();
    }
  }
}
