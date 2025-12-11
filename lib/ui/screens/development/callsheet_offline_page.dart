import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sail_in_co/data/dao/callsheet/callsheet_summary_dao.dart';
import 'package:sail_in_co/data/models/summary/callsheet_summary_response.dart';

class CallsheetOfflinePage extends StatefulWidget {
  const CallsheetOfflinePage({super.key});

  @override
  State<CallsheetOfflinePage> createState() => _CallsheetOfflinePageState();
}

class _CallsheetOfflinePageState extends State<CallsheetOfflinePage> {
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

  String formatDate(String? value) {
    if (value == null || value.isEmpty) return "-";
    try {
      return DateFormat("dd MMM yyyy – HH:mm").format(DateTime.parse(value));
    } catch (_) {
      return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Callsheet Summary Offline")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: load,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text("Pending     : ${summary?.pendingTasks ?? "-"}"),
                  Text("Completed : ${summary?.completedTasks ?? "-"}"),
                  Text("Total          : ${summary?.totalTasks ?? "-"}"),
                  const SizedBox(height: 12),
                  Text("Last Update : ${formatDate(lastUpdate)}"),

                  const SizedBox(height: 30),
                  const Text("Catatan:\nData ini diambil dari SQLite untuk kebutuhan offline."),
                ],
              ),
            ),
    );
  }
}
