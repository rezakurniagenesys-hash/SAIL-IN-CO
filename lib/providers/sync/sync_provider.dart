import 'package:flutter/material.dart';
import 'package:sail_in_co/data/dao/callsheet/callsheet_summary_dao.dart';
import 'package:sail_in_co/data/models/summary/callsheet_summary_response.dart';
import 'package:sail_in_co/data/models/summary/summary_request.dart';
import 'package:sail_in_co/data/repositories/home_repository.dart';
import 'package:sail_in_co/services/auth_service.dart';

class SyncProvider extends ChangeNotifier {
  final homeRepo = HomeRepository();
  final daoCallSheet = CallsheetSummaryDao();

  bool isLoading = false;

  Future<void> init({required VoidCallback onShowLoading, required VoidCallback onHideLoading}) async {
    onShowLoading(); // tampilkan dialog
    await getSummaryChart();
    onHideLoading(); // tutup dialog
  }

  // ===================== Home Dashboard Sync =====================
  Future<void> getSummaryChart() async {
    final userInfo = await AuthService.getUserInfo();

    isLoading = true;
    notifyListeners();

    try {
      final request = SummaryRequest(date: '2025-11-28', salesId: userInfo?.username ?? '');

      final res = await homeRepo.getSummaryChart(request);

      await daoCallSheet.saveSummary(
        SummaryData(pendingTasks: res.data?.pendingTasks, completedTasks: res.data?.completedTasks, totalTasks: res.data?.totalTasks),
      );
    } catch (e) {
      debugPrint("Error loading summary chart: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
