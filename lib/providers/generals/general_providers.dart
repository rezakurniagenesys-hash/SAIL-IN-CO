// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sail_in_co/core/constants/constant_date.dart';
import 'package:sail_in_co/core/utils/connection_utils.dart';
import 'package:sail_in_co/core/utils/date_utils.dart';
import 'package:sail_in_co/data/dao/master/inventory_dao.dart';
import 'package:sail_in_co/data/models/general/general_inventory/general_inventory_request.dart';
import 'package:sail_in_co/data/models/general/general_inventory/general_inventory_response.dart';
import 'package:sail_in_co/data/repositories/generals_repository.dart';
import 'package:sail_in_co/services/auth_service.dart';

class GeneralProviders extends ChangeNotifier {
  final repository = GeneralsRepository();

  final daoInventory = InventoryItemDao();

  bool isLoadingInventory = false;
  List<InventoryItem> inventoryData = [];

  final date = ConstantDate.date;

  Future<void> getInventory(BuildContext context) async {
    final userInfo = await AuthService.getUserInfo();
    inventoryData = [];
    isLoadingInventory = true;
    notifyListeners();

    final online = await ConnectionUtils.isConnected();

    try {
      if (online) {
        final inventoryRequest = GeneralInventoryRequest(page: 1, limit: 100, warehouseId: userInfo?.username, date: DateUtilsHelper.formatYMD(date));
        final res = await repository.getGeneralInventory(generalInventoryRequest: inventoryRequest);
        if (res.statusCode == 200 && res.data != null) {
          final inventoryResponse = GeneralInventoryResponse.fromJson(res.data);
          inventoryData = inventoryResponse.data.inventoryData;
        } else if (res.statusCode == 502) {
          SnackBar snackBar = const SnackBar(content: Text('Bad gateway.'), backgroundColor: Colors.red);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          SnackBar snackBar = SnackBar(content: Text(res.message ?? 'Unknown error'), backgroundColor: Colors.red);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        inventoryData = await daoInventory.getInventoryItems();
        debugPrint("Inventory loaded from SQLite (offline)");
      }
    } catch (e) {
      SnackBar snackBar = SnackBar(content: Text('Error fetching inventory data: $e'), backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      isLoadingInventory = false;
      notifyListeners();
    }
  }
}
