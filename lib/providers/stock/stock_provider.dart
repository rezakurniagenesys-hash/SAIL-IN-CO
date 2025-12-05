// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sail_in_co/data/models/stock/stock_request.dart';
import 'package:sail_in_co/data/models/stock/stock_response.dart';
import 'package:sail_in_co/data/repositories/stock_repository.dart';
import 'package:sail_in_co/services/auth_service.dart';

class StockProvider extends ChangeNotifier {
  final _repoStock = StockRepository();

  TextEditingController searchController = TextEditingController();

  // Date filter - default to today
  final now = DateTime.now();

  // Helper to format date to string YYYY-MM-DD
  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  bool isLoadingStock = false;

  StockResponse? stockResponse;
  List<StockItem>? stockItem;

  Future<void> getStock(BuildContext context) async {
    stockItem = [];
    final userInfo = await AuthService.getUserInfo();
    isLoadingStock = true;
    await Future.delayed(const Duration(milliseconds: 1000));
    notifyListeners();

    try {
      final stockRequest = StockRequest(warehouseId: userInfo?.userId ?? '', date: _formatDate(now), search: searchController.text);
      final res = await _repoStock.getStock(stockRequest: stockRequest);
      if (res.statusCode == 200 && res.data != null) {
        stockResponse = StockResponse.fromJson(res.data);
        stockItem = stockResponse?.data?.stock;
      } else {
        SnackBar snackBar = SnackBar(content: Text(res.message ?? 'Unknown error'), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      debugPrint("Error loading stock data: $e");
    } finally {
      isLoadingStock = false;
      notifyListeners();
    }
  }

  // Clear
  void clear() {
    searchController.clear();
    stockResponse = null;
    stockItem = null;
    isLoadingStock = false;
    notifyListeners();
  }
}
