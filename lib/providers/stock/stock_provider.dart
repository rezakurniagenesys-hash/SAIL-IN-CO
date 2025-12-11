// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sail_in_co/core/constants/constant_date.dart';
import 'package:sail_in_co/core/utils/connection_utils.dart';
import 'package:sail_in_co/core/utils/date_utils.dart';
import 'package:sail_in_co/data/dao/stock/stock_item_dao.dart';
import 'package:sail_in_co/data/models/stock/stock_request.dart';
import 'package:sail_in_co/data/models/stock/stock_response.dart';
import 'package:sail_in_co/data/repositories/stock_repository.dart';
import 'package:sail_in_co/services/auth_service.dart';

class StockProvider extends ChangeNotifier {
  final _repoStock = StockRepository();
  final daoStock = StockItemDao();

  TextEditingController searchController = TextEditingController();

  final date = ConstantDate.date;

  bool isLoadingStock = false;

  StockResponse? stockResponse;
  List<StockItem>? stockItem;
  List<StockItem>? originalStockItem;

  Future<void> getStock(BuildContext context) async {
    stockItem = [];
    final userInfo = await AuthService.getUserInfo();
    isLoadingStock = true;

    notifyListeners();

    final online = await ConnectionUtils.isConnected();

    try {
      if (online) {
        final stockRequest = StockRequest(warehouseId: userInfo?.userId ?? '', date: DateUtilsHelper.formatYMD(date), search: searchController.text);

        final res = await _repoStock.getStock(stockRequest: stockRequest);

        if (res.statusCode == 200 && res.data != null) {
          stockResponse = StockResponse.fromJson(res.data);
          stockItem = stockResponse?.data?.stock ?? [];
          originalStockItem = List.from(stockItem!); // simpan data asli
        }
      } else {
        stockItem = await daoStock.getStockItems();
        originalStockItem = List.from(stockItem!); // simpan data asli
      }
    } catch (e) {
      debugPrint("Error loading stock data: $e");
    } finally {
      isLoadingStock = false;
      notifyListeners();
    }
  }

  void searchStock(BuildContext context) async {
    final query = searchController.text.trim().toLowerCase();

    // Jika pencarian kosong, muat ulang data (online/offline)
    if (query.isEmpty) {
      await getStock(context);
      return;
    }

    // Cek koneksi
    final online = await ConnectionUtils.isConnected();

    if (online) {
      // Mode ONLINE: panggil ulang API dengan parameter search
      getStock(context);
    } else {
      // Mode OFFLINE: filter dari SQLite yang sudah ada di stockItem
      if (stockItem == null) return;

      final filtered = stockItem!.where((item) {
        final name = item.inventoryName?.toLowerCase() ?? '';
        final code = item.inventoryId?.toLowerCase() ?? '';
        return name.contains(query) || code.contains(query);
      }).toList();

      stockItem = filtered;
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
