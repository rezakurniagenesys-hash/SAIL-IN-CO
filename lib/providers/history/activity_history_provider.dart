import 'package:flutter/material.dart';
import 'package:sail_in_co/core/utils/connection_utils.dart';
import 'package:sail_in_co/core/utils/date_utils.dart';
import 'package:sail_in_co/data/dao/activity/activity_history_transaction_dao.dart';
import 'package:sail_in_co/data/models/history/activity_history_response_model.dart';
import 'package:sail_in_co/data/models/history/history_transaction_payload_model.dart';
import 'package:sail_in_co/data/repositories/activity_repository.dart';
import 'package:sail_in_co/services/auth_service.dart';

enum ActivityType { sales, returns, all }

class ActivityHistoryProvider extends ChangeNotifier {
  final repository = ActivityRepository();
  final daoActivityHistory = ActivityHistoryTransactionDao();

  final TextEditingController searchController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  /// Pagination
  int page = 1;
  int limit = 100;
  int totalPages = 1;
  DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime endDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59);

  ActivityType selectedActivityType = ActivityType.all;

  /// States
  bool isLoading = false;
  bool isLoadMore = false;

  /// Data list
  ActivityHistoryResponseModel? activityHistoryResponse;
  List<ActivityHistoryTransaction> dataActivityHistory = [];

  Future<void> getActivityHistory({bool loadMore = false, bool initial = false, required String customerId}) async {
    endDateController.text = DateUtilsHelper.formatYMD(endDate);
    startDateController.text = DateUtilsHelper.formatYMD(startDate);
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
        dataActivityHistory.clear();
        notifyListeners();
      }
      // INITIAL LOAD
      else {
        isLoading = true;
        page = 1;
        dataActivityHistory.clear();
        notifyListeners();
      }
      final request = HistoryTransactionPayloadModel(
        customerId: customerId,
        userId: userInfo?.userId ?? '',
        type: selectedActivityType == ActivityType.sales
            ? 'sales'
            : selectedActivityType == ActivityType.returns
            ? 'return'
            : null,
        startDate: DateUtilsHelper.formatYMD(startDate),
        endDate: DateUtilsHelper.formatYMD(endDate),
        page: page,
        limit: limit,
        salesDate: null,
        search: searchController.text,
      );

      final response = await repository.getActivityHistory(payload: request);

      final data = ActivityHistoryResponseModel.fromJson(response.data);

      if (data.data.transactions.isNotEmpty) {
        if (loadMore) {
          dataActivityHistory.addAll(data.data.transactions);
        } else {
          dataActivityHistory = data.data.transactions;
          totalPages = data.data.pagination.totalPages;
        }
      }

      // END STATE
      if (loadMore) {
        isLoadMore = false;
      } else {
        isLoading = false;
      }
    } else {
      // OFFLINE MODE
      isLoading = true;
      page = 1;
      dataActivityHistory.clear();
      notifyListeners();

      if (selectedActivityType == ActivityType.sales) {
        // Filter hanya sales
        final value = await daoActivityHistory.getByType(customerId: customerId, type: 'sales', search: searchController.text);
        dataActivityHistory = value;
      } else if (selectedActivityType == ActivityType.returns) {
        // Filter hanya return
        final value = await daoActivityHistory.getByType(customerId: customerId, type: 'return', search: searchController.text);
        dataActivityHistory = value;
      } else {
        // Semua tipe transaksi
        final value = await daoActivityHistory.getByCustomerId(customerId, searchController.text);
        dataActivityHistory = value;
      }

      isLoading = false;
    }

    notifyListeners();
  }

  // set start date
  void setStartDate(DateTime date) {
    startDate = date;
    startDateController.text = DateUtilsHelper.formatYMD(date);

    notifyListeners();
  }

  // set end date
  void setEndDate(DateTime date) {
    endDate = date;
    endDateController.text = DateUtilsHelper.formatYMD(date);
    notifyListeners();
  }

  void filterDate(String customerId) {
    page = 1;
    dataActivityHistory.clear();

    getActivityHistory(initial: true, customerId: customerId);
    notifyListeners();
  }

  void setSelectedActivityType(ActivityType type, String customerId) {
    selectedActivityType = type;
    page = 1;
    dataActivityHistory.clear();

    getActivityHistory(initial: true, customerId: customerId);
    notifyListeners();
  }

  void searchActivityHistory(String query, String customerId) {
    searchController.text = query;
    page = 1;
    dataActivityHistory.clear();

    getActivityHistory(initial: true, customerId: customerId);
    notifyListeners();
  }

  void clearData() {
    dataActivityHistory.clear();
    page = 1;
    totalPages = 1;
    searchController.clear();
    selectedActivityType = ActivityType.all;

    notifyListeners();
  }
}
