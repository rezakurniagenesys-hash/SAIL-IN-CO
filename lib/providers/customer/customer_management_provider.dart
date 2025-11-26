import 'package:flutter/material.dart';
import 'package:sail_in_co/data/models/customer/customer_item.dart';
import 'package:sail_in_co/data/models/customer/customer_search_request.dart';
import 'package:sail_in_co/data/repositories/customer_repository.dart';

class CustomerManagementProvider extends ChangeNotifier {
  final _repo = CustomerRepository();

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

  /// INITIAL LOAD ------------------------------------
  Future<void> getCustomers({bool loadMore = false}) async {
    // LOAD MORE
    if (loadMore) {
      if (isLoadMore) return;
      if (page >= totalPages) return;

      isLoadMore = true;
      page++;
      notifyListeners();
    }
    // INITIAL LOAD
    else {
      isLoading = true;
      page = 1;
      customers.clear();
      notifyListeners();
    }

    final request = CustomerSearchRequest(page: page, limit: limit, search: searchText, customerId: customerId, status: status);

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
