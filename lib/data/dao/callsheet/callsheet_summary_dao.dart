import 'package:sail_in_co/data/models/summary/callsheet_summary_response.dart';
import '../../../core/database/app_database.dart';

class CallsheetSummaryDao {
  final dbHelper = AppDatabase.instance;

  // Insert or update (delete old rows first)
  Future<void> saveSummary(SummaryData data) async {
    final db = await dbHelper.database;

    // Hapus semua row agar tidak terjadi duplikasi
    await db.delete("callsheet_summary");

    // Insert row baru
    await db.insert("callsheet_summary", {
      "pending_tasks": data.pendingTasks,
      "completed_tasks": data.completedTasks,
      "total_tasks": data.totalTasks,
      "last_update": DateTime.now().toIso8601String(),
    });
  }

  // Get single offline summary
  Future<SummaryData?> getSummary() async {
    final db = await dbHelper.database;

    final result = await db.query("callsheet_summary", limit: 1);

    if (result.isEmpty) return null;

    final row = result.first;

    return SummaryData(pendingTasks: row["pending_tasks"] as int?, completedTasks: row["completed_tasks"] as int?, totalTasks: row["total_tasks"] as int?);
  }

  // Get last update
  Future<String?> getLastUpdate() async {
    final db = await dbHelper.database;

    final result = await db.query("callsheet_summary", columns: ["last_update"], limit: 1);

    if (result.isEmpty) return null;

    return result.first["last_update"] as String?;
  }
}
