import 'package:sail_in_co/data/models/history/shipping_sales_order_payload.dart';
import 'package:sqflite/sqflite.dart';
import '../../../core/database/app_database.dart';

class ShippingSalesOrderDao {
  final dbHelper = AppDatabase.instance;

  // =====================================================
  // INSERT SHIPPING SALES ORDER (OFFLINE)
  // =====================================================
  Future<int> saveShipping(ShippingSalesOrderPayload payload) async {
    final db = await dbHelper.database;

    return await db.insert('shipping_sales_orders', {
      'sales_order_id': payload.salesOrderId,
      'user_record': payload.userRecord,

      // SYNC CONTROL
      'sync_status': 0, // pending
      'created_at': DateTime.now().toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // =====================================================
  // GET PENDING / ERROR (UNTUK SYNC)
  // =====================================================
  Future<List<Map<String, dynamic>>> getPendingShipping() async {
    final db = await dbHelper.database;

    return await db.query('shipping_sales_orders', where: 'sync_status IN (0, 2)', orderBy: 'created_at ASC');
  }

  // =====================================================
  // UPDATE SYNC ERROR
  // =====================================================
  Future<void> markSyncError(int localId, String errorMessage) async {
    final db = await dbHelper.database;

    await db.update('shipping_sales_orders', {'sync_status': 2, 'sync_error': errorMessage}, where: 'local_id = ?', whereArgs: [localId]);
  }

  // =====================================================
  // SYNC SUCCESS → DELETE DATA
  // =====================================================
  Future<void> deleteAfterSyncSuccess(int localId) async {
    final db = await dbHelper.database;

    await db.delete('shipping_sales_orders', where: 'local_id = ?', whereArgs: [localId]);
  }

  // =====================================================
  // CLEAR ALL (DEBUG)
  // =====================================================
  Future<int> clearAll() async {
    final db = await dbHelper.database;
    return await db.delete('shipping_sales_orders');
  }
}
