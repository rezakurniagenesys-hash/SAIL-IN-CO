import 'package:sail_in_co/data/models/quicksales/outstanding_payment_payload_model.dart';
import 'package:sqflite/sqflite.dart';
import '../../../core/database/app_database.dart';

class OutstandingPaymentDao {
  final dbHelper = AppDatabase.instance;

  // =====================================================
  // INSERT OUTSTANDING PAYMENT (OFFLINE)
  // =====================================================
  Future<int> saveOutstandingPayment(OutstandingPaymentPayloadModel model) async {
    final db = await dbHelper.database;

    return await db.insert('outstanding_payments', {
      'invoice_id': model.invoiceId,
      'slip_id': model.slipId,
      'sales_return_id': model.salesReturnId,
      'sales_return_payment': model.salesReturnPayment,
      'remaining_payment': model.remainingPayment,
      'user_record': model.userRecord,

      // SYNC CONTROL
      'sync_status': 0, // pending
      'created_at': DateTime.now().toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // =====================================================
  // GET PENDING / ERROR (UNTUK SYNC)
  // =====================================================
  Future<List<Map<String, dynamic>>> getPendingOutstandingPayments() async {
    final db = await dbHelper.database;

    return await db.query('outstanding_payments', where: 'sync_status IN (0, 2)', orderBy: 'created_at ASC');
  }

  // =====================================================
  // GET SINGLE BY LOCAL ID
  // =====================================================
  Future<OutstandingPaymentPayloadModel?> getByLocalId(int localId) async {
    final db = await dbHelper.database;

    final result = await db.query('outstanding_payments', where: 'local_id = ?', whereArgs: [localId]);

    if (result.isEmpty) return null;

    final row = result.first;

    return OutstandingPaymentPayloadModel(
      invoiceId: row['invoice_id'] as String,
      slipId: row['slip_id'] as String,
      salesReturnId: (row['sales_return_id'] as String?) ?? '',
      salesReturnPayment: row['sales_return_payment'] as num,
      remainingPayment: row['remaining_payment'] as num,
      userRecord: row['user_record'] as String,
    );
  }

  // =====================================================
  // MARK SYNC ERROR
  // =====================================================
  Future<void> markSyncError(int localId, String errorMessage) async {
    final db = await dbHelper.database;

    await db.update('outstanding_payments', {'sync_status': 2, 'sync_error': errorMessage}, where: 'local_id = ?', whereArgs: [localId]);
  }

  // =====================================================
  // SYNC SUCCESS → DELETE DATA
  // =====================================================
  Future<void> deleteAfterSyncSuccess(int localId) async {
    final db = await dbHelper.database;

    await db.delete('outstanding_payments', where: 'local_id = ?', whereArgs: [localId]);
  }

  // =====================================================
  // CLEAR ALL (DEBUG / RESET)
  // =====================================================
  Future<int> clearAll() async {
    final db = await dbHelper.database;
    return await db.delete('outstanding_payments');
  }
}
