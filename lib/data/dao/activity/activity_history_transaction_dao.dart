import 'package:sail_in_co/data/models/history/activity_history_response_model.dart';
import 'package:sqflite/sqflite.dart';
import '../../../core/database/app_database.dart';

class ActivityHistoryTransactionDao {
  final dbHelper = AppDatabase.instance;

  // =====================================================
  // INSERT / REPLACE (CACHE DARI API)
  // =====================================================
  Future<void> insertAll({required String customerId, required List<ActivityHistoryTransaction> items}) async {
    final db = await dbHelper.database;
    final batch = db.batch();

    for (final item in items) {
      batch.insert('activity_history_transactions', {
        'customer_id': customerId,

        'sales_id': item.salesId,
        'transaction_date': item.transactionDate,

        'shipping_id': item.shippingId?.toString(),
        'last_update': item.lastUpdate?.toString(),

        'total_qty': item.totalQty is int ? item.totalQty : null,
        'total_qty2': item.totalQty2 is int ? item.totalQty2 : null,

        'grand_total': item.grandTotal,
        'transaction_type': item.transactionType,
        'flag_paid': item.flagPaid,

        'inventory_names': item.inventoryNames?.toString(),

        'created_at': DateTime.now().toIso8601String(),
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await batch.commit(noResult: true);
  }

  // =====================================================
  // GET ALL HISTORY (GLOBAL)
  // =====================================================
  Future<List<ActivityHistoryTransaction>> getAll() async {
    final db = await dbHelper.database;

    final result = await db.query('activity_history_transactions', orderBy: 'transaction_date DESC');

    return result.map(_mapRowToModel).toList();
  }

  // =====================================================
  // GET BY CUSTOMER ID
  // =====================================================
  Future<List<ActivityHistoryTransaction>> getByCustomerId(String customerId, String search) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'activity_history_transactions',
      where: 'customer_id = ? AND (inventory_names LIKE ? OR sales_id LIKE ?)',
      whereArgs: [customerId, '%$search%', '%$search%'],
      orderBy: 'transaction_date DESC',
    );

    return result.map(_mapRowToModel).toList();
  }

  // =====================================================
  // FILTER BY TYPE (SALE / RETURN)
  // =====================================================
  Future<List<ActivityHistoryTransaction>> getByType({required String customerId, required String type, required String search}) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'activity_history_transactions',
      where: 'customer_id = ? AND transaction_type = ? AND (inventory_names LIKE ? OR sales_id LIKE ?)',
      whereArgs: [customerId, type, '%$search%', '%$search%'],
      orderBy: 'transaction_date DESC',
    );

    return result.map(_mapRowToModel).toList();
  }

  // =====================================================
  // CLEAR CACHE (ALL)
  // =====================================================
  Future<int> clearAll() async {
    final db = await dbHelper.database;
    return await db.delete('activity_history_transactions');
  }

  // =====================================================
  // CLEAR PER CUSTOMER
  // =====================================================
  Future<int> clearByCustomer(String customerId) async {
    final db = await dbHelper.database;
    return await db.delete('activity_history_transactions', where: 'customer_id = ?', whereArgs: [customerId]);
  }

  // =====================================================
  // PRIVATE MAPPER
  // =====================================================
  ActivityHistoryTransaction _mapRowToModel(Map<String, dynamic> row) {
    return ActivityHistoryTransaction(
      salesId: row['sales_id'],
      transactionDate: row['transaction_date'],
      shippingId: row['shipping_id'],
      lastUpdate: row['last_update'],
      totalQty: row['total_qty'],
      totalQty2: row['total_qty2'],
      grandTotal: row['grand_total'],
      transactionType: row['transaction_type'],
      flagPaid: row['flag_paid'],
      inventoryNames: row['inventory_names'],
    );
  }
}
