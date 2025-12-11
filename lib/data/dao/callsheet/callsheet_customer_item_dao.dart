import 'package:sqflite/sqflite.dart';
import '../../../core/database/app_database.dart';
import 'package:sail_in_co/data/models/customer/customer_item.dart';

class CallsheetCustomerItemDao {
  final dbHelper = AppDatabase.instance;

  /// Save / sync offline customers
  Future<void> saveCustomers(List<CustomerItem> items) async {
    final db = await dbHelper.database;

    // Clear existing
    await db.delete("customers");

    // Insert new
    for (var item in items) {
      await db.insert("customers", {
        "no_acc6": item.noAcc6,
        "nm_acc6": item.nmAcc6,
        "address": item.address,
        "phone": item.phone,
        "status_visit": item.statusVisit,
        "schedule_id": item.scheduleId,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  /// Get all customers offline
  Future<List<CustomerItem>> getCustomers() async {
    final db = await dbHelper.database;

    final rows = await db.query("customers");

    return rows.map((row) {
      return CustomerItem(
        noAcc6: row["no_acc6"] as String?,
        nmAcc6: row["nm_acc6"] as String?,
        address: row["address"] as String?,
        phone: row["phone"] as String?,
        statusVisit: row["status_visit"] as int?,
        scheduleId: row["schedule_id"] as String?,
      );
    }).toList();
  }

  /// Get 1 customer by ID
  Future<CustomerItem?> getCustomerById(String id) async {
    final db = await dbHelper.database;

    final rows = await db.query("customers", where: "no_acc6 = ?", whereArgs: [id], limit: 1);

    if (rows.isNotEmpty) {
      final row = rows.first;
      return CustomerItem(
        noAcc6: row["no_acc6"] as String?,
        nmAcc6: row["nm_acc6"] as String?,
        address: row["address"] as String?,
        phone: row["phone"] as String?,
        statusVisit: row["status_visit"] as int?,
        scheduleId: row["schedule_id"] as String?,
      );
    }

    return null;
  }

  /// Get customers by status
  Future<List<CustomerItem>> getCustomersByStatus(List<int> statuses, {String? search}) async {
    final db = await dbHelper.database;

    final List<String> whereConditions = [];
    final List<dynamic> whereArgs = [];

    // Add status condition
    final placeholders = List.filled(statuses.length, '?').join(',');
    whereConditions.add("status_visit IN ($placeholders)");
    whereArgs.addAll(statuses);

    // Add search condition if provided
    if (search != null && search.isNotEmpty) {
      whereConditions.add("(nm_acc6 LIKE ? OR address LIKE ?)");
      whereArgs.add('%$search%');
      whereArgs.add('%$search%');
    }

    final whereClause = whereConditions.join(' AND ');

    final rows = await db.query("customers", where: whereClause, whereArgs: whereArgs);

    return rows.map((row) {
      return CustomerItem(
        noAcc6: row["no_acc6"] as String?,
        nmAcc6: row["nm_acc6"] as String?,
        address: row["address"] as String?,
        phone: row["phone"] as String?,
        statusVisit: row["status_visit"] as int?,
        scheduleId: row["schedule_id"] as String?,
      );
    }).toList();
  }

  /// Delete all
  Future<void> clear() async {
    final db = await dbHelper.database;
    await db.delete("customers");
  }
}
