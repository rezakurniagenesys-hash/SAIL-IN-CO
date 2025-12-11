import 'package:sail_in_co/data/models/payment/payment_method_response.dart';
import 'package:sqflite/sqflite.dart';
import '../../../core/database/app_database.dart';

class MethodPaymentDao {
  final dbHelper = AppDatabase.instance;

  /// Save fresh sync: delete old → insert new
  Future<void> savePaymentMethods(List<PaymentMethodData> list) async {
    final db = await dbHelper.database;

    // Clear old data
    await db.delete("payment_methods");

    // Insert new items
    for (var item in list) {
      await db.insert("payment_methods", {
        "slip_id": item.slipId,
        "slip_name": item.slipName,
        "slip_type": item.slipType,
        "currency_id": item.currencyId,
        "sales_acc_code": item.salesAccCode,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  /// Get all payment methods from SQLite
  Future<List<PaymentMethodData>> getPaymentMethods() async {
    final db = await dbHelper.database;

    final result = await db.query("payment_methods");

    return result.map((row) {
      return PaymentMethodData(
        slipId: row["slip_id"] as String,
        slipName: row["slip_name"] as String,
        slipType: row["slip_type"] as String,
        currencyId: row["currency_id"] as String,
        salesAccCode: row["sales_acc_code"] as String,
      );
    }).toList();
  }

  /// Get by Slip ID
  Future<PaymentMethodData?> getById(String slipId) async {
    final db = await dbHelper.database;

    final result = await db.query("payment_methods", where: "slip_id = ?", whereArgs: [slipId], limit: 1);

    if (result.isEmpty) return null;

    final row = result.first;

    return PaymentMethodData(
      slipId: row["slip_id"] as String,
      slipName: row["slip_name"] as String,
      slipType: row["slip_type"] as String,
      currencyId: row["currency_id"] as String,
      salesAccCode: row["sales_acc_code"] as String,
    );
  }

  /// Delete all
  Future<void> clearTable() async {
    final db = await dbHelper.database;
    await db.delete("payment_methods");
  }
}
