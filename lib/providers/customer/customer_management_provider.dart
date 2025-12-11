import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sail_in_co/data/models/auth/auth_response_model.dart';
import 'package:sail_in_co/data/models/customer/customer_item.dart';
import 'package:sail_in_co/data/models/customer/customer_search_request.dart';
import 'package:sail_in_co/data/repositories/customer_repository.dart';
import 'package:sail_in_co/services/auth_service.dart';

class CustomerManagementProvider extends ChangeNotifier {
  final _repo = CustomerRepository();

  // Date filter - default to today
  final now = DateTime.now();

  // Helper to format date to string YYYY-MM-DD
  // '2025-11-28',
  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

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

  Future<void> getCustomers({bool loadMore = false, bool initial = false}) async {
    userInfo = await AuthService.getUserInfo();
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
      // date: _formatDate(now),
      // date: '2025-11-28',
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

    notifyListeners();
  }

  /// For Search & Filter --------------------------------
  void applyFilter({String? search, String? customerId, int? status}) {
    searchText = search;
    this.customerId = customerId;
    this.status = status;
    page = 1;

    getCustomers();
  }

  void clearData() {
    customers.clear();
    notifyListeners();
  }
}
