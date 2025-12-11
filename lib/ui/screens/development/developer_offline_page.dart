import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sail_in_co/data/dao/callsheet/callsheet_summary_dao.dart';
import 'package:sail_in_co/data/models/summary/callsheet_summary_response.dart';

class DeveloperOfflinePage extends StatefulWidget {
  const DeveloperOfflinePage({super.key});

  @override
  State<DeveloperOfflinePage> createState() => _DeveloperOfflinePageState();
}

class _DeveloperOfflinePageState extends State<DeveloperOfflinePage> {
  final dao = CallsheetSummaryDao();
  SummaryData? summary;
  String? lastUpdate;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    setState(() => loading = true);

    summary = await dao.getSummary();
    lastUpdate = await dao.getLastUpdate();

    setState(() => loading = false);
  }

  String formatLastUpdate(String? value) {
    if (value == null || value.isEmpty) return "-";

    try {
      final date = DateTime.parse(value);
      return DateFormat("dd MMM yyyy – HH:mm").format(date);
    } catch (_) {
      return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Developer Offline Data")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: load,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Text("""
=== CALLSHEET SUMMARY DATA ===

Pending Tasks : ${summary?.pendingTasks ?? "-"}
Completed Tasks : ${summary?.completedTasks ?? "-"}
Total Tasks : ${summary?.totalTasks ?? "-"}

Last Update
→ ${formatLastUpdate(lastUpdate)}

==============================
Note:
Halaman ini khusus untuk developer.
Gunakan untuk memeriksa data offline SQLite.
""", style: const TextStyle(fontSize: 16)),
              ),
            ),
    );
  }
}
