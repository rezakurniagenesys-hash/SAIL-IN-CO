// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sail_in_co/core/constants/constant_date.dart';
import 'package:sail_in_co/core/utils/connection_utils.dart';
import 'package:sail_in_co/core/utils/date_utils.dart';
import 'package:sail_in_co/data/dao/master/inventory_dao.dart';
import 'package:sail_in_co/data/models/general/general_inventory/general_inventory_request.dart';
import 'package:sail_in_co/data/models/general/general_inventory/general_inventory_response.dart';
import 'package:sail_in_co/data/models/general/general_kunci_stock/default_setting_lock_stock_response.dart';
import 'package:sail_in_co/data/repositories/generals_repository.dart';
import 'package:sail_in_co/services/auth_service.dart';
import 'package:sail_in_co/services/lockstock_service.dart';
import 'package:sail_in_co/ui/widgets/app_snackbar.dart';

class GeneralProviders extends ChangeNotifier {
  final repository = GeneralsRepository();

  final daoInventory = InventoryItemDao();

  bool isLoadingInventory = false;
  List<InventoryItem> inventoryData = [];

  bool isLoadingLockStock = false;
  List<DefaultSettingLockStockData> lockStockData = [];

  final date = ConstantDate.date;

  Future<bool> getInventory(BuildContext context) async {
    final userInfo = await AuthService.getUserInfo();
    inventoryData = [];
    isLoadingInventory = true;
    notifyListeners();

    final online = await ConnectionUtils.isConnected();

    try {
      if (online) {
        final inventoryRequest = GeneralInventoryRequest(page: 1, limit: 100, warehouseId: userInfo?.userId, date: DateUtilsHelper.formatYMD(date));
        final res = await repository.getGeneralInventory(generalInventoryRequest: inventoryRequest);
        if (res.statusCode == 200 && res.data != null) {
          final inventoryResponse = GeneralInventoryResponse.fromJson(res.data);
          inventoryData = inventoryResponse.data.inventoryData;
          await daoInventory.saveInventoryItems(inventoryData);
          return true;
        } else if (res.statusCode == 502) {
          AppSnackBar.show(context, message: 'Bad gateway.', color: Colors.red);

          return false;
        } else {
          AppSnackBar.show(context, message: res.message ?? 'Unknown error', color: Colors.red);
          return false;
        }
      } else {
        inventoryData = await daoInventory.getInventoryItems();
        debugPrint("Inventory loaded from SQLite (offline)");
        return true;
      }
    } catch (e) {
      AppSnackBar.show(context, message: 'Error fetching inventory data: $e', color: Colors.red);
      return false;
    } finally {
      isLoadingInventory = false;
      notifyListeners();
    }
  }

  // Get - Lock Stock
  Future<bool> getLockStock(BuildContext context) async {
    lockStockData = [];
    isLoadingLockStock = true;
    notifyListeners();

    final online = await ConnectionUtils.isConnected();

    try {
      if (online) {
        final res = await repository.getLockStock();
        if (res.statusCode == 200 && res.data != null) {
          final lockStockResponse = DefaultSettingLockStockResponse.fromJson(res.data);
          lockStockData = lockStockResponse.data;
          await LockStockService.saveFromApi(lockStockResponse.data.map((e) => e.toJson()).toList());
          return true;
        } else if (res.statusCode == 502) {
          AppSnackBar.show(context, message: 'Bad gateway.', color: Colors.red);
          return false;
        } else {
          AppSnackBar.show(context, message: res.message ?? 'Unknown error', color: Colors.red);
          return false;
        }
      } else {
        return true;
      }
    } catch (e) {
      AppSnackBar.show(context, message: 'Error fetching lock stock data: $e', color: Colors.red);
      return false;
    } finally {
      isLoadingLockStock = false;
      notifyListeners();
    }
  }
}
