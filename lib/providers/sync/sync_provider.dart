import 'package:flutter/material.dart';
import 'package:sail_in_co/core/constants/constant_date.dart';
import 'package:sail_in_co/core/utils/connection_utils.dart';
import 'package:sail_in_co/core/utils/date_utils.dart';
import 'package:sail_in_co/data/dao/callsheet/callsheet_customer_detail_dao.dart';
import 'package:sail_in_co/data/dao/callsheet/callsheet_customer_item_dao.dart';
import 'package:sail_in_co/data/dao/callsheet/callsheet_summary_dao.dart';
import 'package:sail_in_co/data/dao/master/inventory_dao.dart';
import 'package:sail_in_co/data/dao/master/method_payment_dao.dart';
import 'package:sail_in_co/data/dao/stock/stock_item_dao.dart';
import 'package:sail_in_co/data/models/customer/customer_detail_response.dart';
import 'package:sail_in_co/data/models/customer/customer_search_request.dart';
import 'package:sail_in_co/data/models/general/general_inventory/general_inventory_request.dart';
import 'package:sail_in_co/data/models/general/general_inventory/general_inventory_response.dart';
import 'package:sail_in_co/data/models/payment/payment_method_response.dart';
import 'package:sail_in_co/data/models/stock/stock_request.dart';
import 'package:sail_in_co/data/models/stock/stock_response.dart';
import 'package:sail_in_co/data/models/summary/callsheet_summary_response.dart';
import 'package:sail_in_co/data/models/summary/summary_request.dart';
import 'package:sail_in_co/data/repositories/customer_repository.dart';
import 'package:sail_in_co/data/repositories/generals_repository.dart';
import 'package:sail_in_co/data/repositories/home_repository.dart';
import 'package:sail_in_co/data/repositories/payment_repository.dart';
import 'package:sail_in_co/data/repositories/stock_repository.dart';
import 'package:sail_in_co/services/auth_service.dart';

class SyncProvider extends ChangeNotifier {
  final repoHome = HomeRepository();
  final repoStock = StockRepository();
  final repoGenerals = GeneralsRepository();
  final repoCustomer = CustomerRepository();
  final repoPayment = PaymentRepository();

  final daoCallSheet = CallsheetSummaryDao();
  final daoStock = StockItemDao();
  final daoInventory = InventoryItemDao();
  final daoCallsheetCustomer = CallsheetCustomerItemDao();
  final daoMethodPayment = MethodPaymentDao();
  final daoCustomerDetail = CustomerDetailDao();

  final date = ConstantDate.date;

  /// Initialize Sync (Summary + Stock)
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

    debugPrint("✅ Sync Detail Customer Selesai (${customerList.length} customer)");
    notifyListeners();
  }
}
