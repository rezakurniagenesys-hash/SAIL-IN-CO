// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sail_in_co/data/models/general/general_inventory/general_inventory_request.dart';
import 'package:sail_in_co/data/models/general/general_inventory/general_inventory_response.dart';
import 'package:sail_in_co/data/repositories/generals_repository.dart';
import 'package:sail_in_co/services/auth_service.dart';

class GeneralProviders extends ChangeNotifier {
  final repository = GeneralsRepository();

  bool isLoadingInventory = false;
  List<InventoryItem> inventoryData = [];

  // Date filter - default to today
  final now = DateTime.now();

  // Helper to format date to string YYYY-MM-DD
  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  Future<void> getInventory(BuildContext context) async {
    final userInfo = await AuthService.getUserInfo();
    inventoryData = [];
    isLoadingInventory = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    notifyListeners();

    try {
      final inventoryRequest = GeneralInventoryRequest(page: 1, limit: 100, warehouseId: userInfo?.username, date: _formatDate(now));
      final res = await repository.getGeneralInventory(generalInventoryRequest: inventoryRequest);
      if (res.statusCode == 200 && res.data != null) {
        final inventoryResponse = GeneralInventoryResponse.fromJson(res.data);
        inventoryData = inventoryResponse.data.inventoryData;
      } else if (res.statusCode == 502) {
        SnackBar snackBar = const SnackBar(content: Text('Bad gateway.'), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } 
      else {
        SnackBar snackBar = SnackBar(content: Text(res.message ?? 'Unknown error'), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
