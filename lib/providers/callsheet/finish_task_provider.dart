import 'package:flutter/material.dart';
import 'package:sail_in_co/core/constants/constant_date.dart';
import 'package:sail_in_co/core/utils/connection_utils.dart';
import 'package:sail_in_co/core/utils/date_utils.dart';
import 'package:sail_in_co/data/dao/callsheet/callsheet_customer_item_dao.dart';
import 'package:sail_in_co/data/models/auth/auth_response_model.dart';
import 'package:sail_in_co/data/models/customer/customer_item.dart';
import 'package:sail_in_co/data/models/customer/customer_search_request.dart';
import 'package:sail_in_co/data/repositories/customer_repository.dart';
import 'package:sail_in_co/services/auth_service.dart';

class FinishTaskProvider extends ChangeNotifier {
  final _repo = CustomerRepository();
  final callsheetCustomerItemDao = CallsheetCustomerItemDao();

  final date = ConstantDate.date;

  /// Data list
  List<CustomerItem> customers = [];

  /// Pagination
  int page = 1;
  int limit = 20;
  int totalPages = 1;

  /// States
  bool isLoading = false;
  bool isLoadMore = false;

  /// Filters (opsional)
  String? searchText;
  String? customerId;
  int? status;

  /// User Info
  UserInfo? userInfo;

  Future<void> getFinishTask({bool loadMore = false, bool initial = false}) async {
    userInfo = await AuthService.getUserInfo();
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
        searchText = null;
        customerId = null;
        status = null;
        isLoading = true;
        page = 1;
        customers.clear();
        notifyListeners();
      }
      // INITIAL LOAD
      else {
        isLoading = true;
        page = 1;
        customers.clear();
        notifyListeners();
      }
      final request = CustomerSearchRequest(
        page: page,
        limit: limit,
        search: searchText,
        customerId: customerId,
        status: status,
        date: DateUtilsHelper.formatYMD(date),
        salesId: userInfo?.userId ?? '',
      );

      final response = await _repo.getCustomerManagement(request);

      if (response?.data?.customerData != null) {
        if (loadMore) {
          customers.addAll(response!.data!.customerData!);
        } else {
          customers = response!.data!.customerData!;
          totalPages = response.data!.pagination?.totalPages ?? 1;
        }
      }

      // END STATE
      if (loadMore) {
        isLoadMore = false;
      } else {
        isLoading = false;
      }
    } else {
      if (status == null) {
        customers = await callsheetCustomerItemDao.getCustomersByStatus([0, 1, 2], search: searchText);
      } else if (status == 0) {
        customers = await callsheetCustomerItemDao.getCustomersByStatus([0], search: searchText);
      } else if (status == 1) {
        customers = await callsheetCustomerItemDao.getCustomersByStatus([1, 2], search: searchText);
      }
    }

    notifyListeners();
  }

  /// For Search & Filter --------------------------------
  void applyFilter({String? search, String? customerId, int? status}) {
    searchText = search;
    this.customerId = customerId;
    this.status = status;
    page = 1;

    print('Apply Filter: search=$searchText, customerId=$customerId, status=$status');

    getFinishTask();
  }

  void clearData() {
    customers.clear();
    notifyListeners();
  }
}
