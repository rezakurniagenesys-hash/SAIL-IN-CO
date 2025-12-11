// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sail_in_co/core/utils/connection_utils.dart';
import 'package:sail_in_co/data/dao/callsheet/callsheet_summary_dao.dart';
import 'package:sail_in_co/data/models/auth/auth_response_model.dart';
import 'package:sail_in_co/data/models/stock/stock_request.dart';
import 'package:sail_in_co/data/models/stock/stock_response.dart';
import 'package:sail_in_co/data/models/summary/callsheet_summary_response.dart';
import 'package:sail_in_co/data/models/summary/summary_request.dart';
import 'package:sail_in_co/data/repositories/home_repository.dart';
import 'package:sail_in_co/data/repositories/stock_repository.dart';
import 'package:sail_in_co/services/auth_service.dart';

class HomeProvider extends ChangeNotifier {
  final _repo = HomeRepository();
  final _repoStock = StockRepository();
  final daoCallSheet = CallsheetSummaryDao();

  UserInfo? userInfo;
  bool isLoading = false;
  bool isLoadingStock = false;

  CallsheetSummaryResponse? summaryResponse;
  SummaryData? summaryData;

  StockResponse? stockResponse;
  List<StockItem>? stockItem;

  // Date filter - default to today
  final now = DateTime.now();

  // Helper to format date to string YYYY-MM-DD
  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  void init(BuildContext context) {
    loadUserInfo();
    getSummaryChart(context);
    getStock(context);
  }

  Future<void> loadUserInfo() async {
    try {
      userInfo = await AuthService.getUserInfo();
    } catch (e) {
      debugPrint("Error loading user info: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> getSummaryChart(BuildContext context) async {
    summaryData = null;
    isLoading = true;
    notifyListeners();

    final online = await ConnectionUtils.isConnected();

    try {
      if (online) {
        final request = SummaryRequest(
          // date: _formatDate(now),
          date: '2025-11-28',
          salesId: userInfo?.userId ?? '',
        );
        final res = await _repo.getSummaryChart(request);
        if (res.statusCode == 200 && res.data != null) {
          summaryResponse = CallsheetSummaryResponse.fromJson(res.data);
          summaryData = summaryResponse?.data;
          debugPrint("Summary chart: updated from API");
        } else if (res.statusCode == 502 || res.statusCode == 500) {
          SnackBar snackBar = const SnackBar(content: Text('Bad gateway.'), backgroundColor: Colors.red);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          SnackBar snackBar = SnackBar(content: Text(res.message ?? 'Unknown error'), backgroundColor: Colors.red);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        summaryData = await daoCallSheet.getSummary();
        debugPrint("Summary chart: loaded from SQLite (offline)");
      }
    } catch (e) {
      debugPrint("Error loading summary chart: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // getStock
  Future<void> getStock(BuildContext context) async {
    isLoadingStock = true;
    notifyListeners();

    try {
      final stockRequest = StockRequest(warehouseId: userInfo?.userId ?? '', date: _formatDate(now));
      final res = await _repoStock.getStock(stockRequest: stockRequest);
      if (res.statusCode == 200 && res.data != null) {
        stockResponse = StockResponse.fromJson(res.data);
        stockItem = stockResponse?.data?.stock;
      } else if (res.statusCode == 502 || res.statusCode == 500) {
        SnackBar snackBar = const SnackBar(content: Text('Bad gateway.'), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
}
