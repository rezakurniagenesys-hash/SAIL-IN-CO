// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sail_in_co/core/constants/constant_date.dart';
import 'package:sail_in_co/core/utils/connection_utils.dart';
import 'package:sail_in_co/core/utils/date_utils.dart';
import 'package:sail_in_co/data/dao/callsheet/callsheet_summary_dao.dart';
import 'package:sail_in_co/data/dao/pattycash/pattycash_dao.dart';
import 'package:sail_in_co/data/dao/stock/stock_item_dao.dart';
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
  final daoStock = StockItemDao();
  final daoPattycashDao = PattycashDao();

  UserInfo? userInfo;
  bool isLoading = false;
  bool isLoadingStock = false;

  num remainingBalancePattyCash = 0;

  CallsheetSummaryResponse? summaryResponse;
  SummaryData? summaryData;

  StockResponse? stockResponse;
  List<StockItem>? stockItem;

  final date = ConstantDate.date;

  void init(BuildContext context) {
    loadUserInfo();
    getSummaryChart(context);
    getStock(context);
    getPattyCash(context);
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
    final userInfoService = await AuthService.getUserInfo();
    summaryData = null;
    isLoading = true;
    notifyListeners();

    final online = await ConnectionUtils.isConnected();

    try {
      if (online) {
        final request = SummaryRequest(
          // date: _formatDate(now),
          date: DateUtilsHelper.formatYMD(date),
          salesId: userInfoService?.userId ?? '',
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
    final userInfoService = await AuthService.getUserInfo();
    stockItem = null;
    isLoadingStock = true;
    notifyListeners();

    final online = await ConnectionUtils.isConnected();

    try {
      if (online) {
        final stockRequest = StockRequest(warehouseId: userInfoService?.userId ?? '000', date: DateUtilsHelper.formatYMD(date));
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
      } else {
        stockItem = await daoStock.getStockItems();
        debugPrint("Stock data: loaded from SQLite (offline)");
      }
    } catch (e) {
      debugPrint("Error loading stock data: $e");
    } finally {
      isLoadingStock = false;
      notifyListeners();
    }
  }

  Future<void> getPattyCash(BuildContext context) async {
    final userInfoService = await AuthService.getUserInfo();

    final online = await ConnectionUtils.isConnected();

    try {
      if (online) {
        final res = await _repo.getPattyCash(userId: userInfoService?.userId ?? '');
        if (res.statusCode == 201 && res.data != null) {
          final data = res.data;
          remainingBalancePattyCash = data['sisaSaldo'] ?? 0;
        } else if (res.statusCode == 502 || res.statusCode == 500) {
          SnackBar snackBar = const SnackBar(content: Text('Bad gateway.'), backgroundColor: Colors.red);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          SnackBar snackBar = SnackBar(content: Text(res.message ?? 'Unknown error'), backgroundColor: Colors.red);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        final localPattyCash = await daoPattycashDao.getPattyCash();
        if (localPattyCash != null) {
          remainingBalancePattyCash = localPattyCash;
          debugPrint("Patty cash data: loaded from SQLite (offline)");
        }
      }
    } catch (e) {
      debugPrint("Error loading patty cash data: $e");
    } finally {
      notifyListeners();
    }
  }
}
