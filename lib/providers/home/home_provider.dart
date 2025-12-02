import 'package:flutter/material.dart';
import 'package:sail_in_co/data/models/auth/auth_response_model.dart';
import 'package:sail_in_co/data/models/summary/callsheet_summary_response.dart';
import 'package:sail_in_co/data/models/summary/summary_request.dart';
import 'package:sail_in_co/data/repositories/home_repository.dart';
import 'package:sail_in_co/services/auth_service.dart';

class HomeProvider extends ChangeNotifier {
  final _repo = HomeRepository();
  UserInfo? userInfo;
  bool isLoading = false;

  SummaryData? summaryData;

  // Date filter - default to today
  final now = DateTime.now();

  // Helper to format date to string YYYY-MM-DD
  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  void init() {
    loadUserInfo();
    getSummaryChart();
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

  Future<void> getSummaryChart() async {
    isLoading = true;

    await Future.delayed(const Duration(milliseconds: 1000));

    notifyListeners();

    try {
      final request = SummaryRequest(date: _formatDate(now), salesId: userInfo?.username ?? '');
      final res = await _repo.getSummaryChart(request);
      summaryData = res.data;
      print("Summary chart data loaded: ${summaryData?.toJson()}");
    } catch (e) {
      debugPrint("Error loading summary chart: $e");
    } finally {
      isLoading = false;
      // Shoiw toast error handled in repository
      notifyListeners();
    }
  }
}
