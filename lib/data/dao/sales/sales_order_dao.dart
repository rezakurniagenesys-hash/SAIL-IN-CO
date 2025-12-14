import 'dart:convert';

import 'package:sail_in_co/data/models/salesorder/sales_order_detail.dart';
import 'package:sail_in_co/data/models/salesorder/sales_order_payload_model.dart';
import 'package:sqflite/sqflite.dart';
import '../../../core/database/app_database.dart';

class SalesOrderDao {
  final dbHelper = AppDatabase.instance;

  // =====================================================
  // INSERT SALES ORDER (OFFLINE)
  // =====================================================
  Future<int> saveSalesOrder(SalesOrderPayloadModel model) async {
    final db = await dbHelper.database;
    return await db.insert('sales_order_header', {
      'sales_order_date': model.salesOrderDate,
      'customer_id': model.customerId,
      'area_id': model.areaId,
      'sales_id': model.salesId,
      'payment_type': model.paymentType,
      'source_id': model.sourceId,
      'warehouse_id': model.warehouseId,
      'currency_id': model.currencyId,
      'rate': model.rate,
      'sub_total': model.subTotal,
      'discount': model.discount,
      'total': model.total,
      'grand_total': model.grandTotal,
      'notes': model.notes,
      'is_void': model.isVoid,
      'status': model.status,
      'destination_address': model.destinationAddress,
      'sales_type': model.salesType,
      'user_record': model.userRecord,
      // DETAIL JSON
      'details_json': jsonEncode(model.details.map((e) => e.toJson()).toList()),

      // SYNC CONTROL
      'sync_status': 0, // pending
      'created_at': DateTime.now().toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // =====================================================
  // GET ALL PENDING / ERROR (UNTUK SYNC)
  // =====================================================
  Future<List<Map<String, dynamic>>> getPendingSalesOrders() async {
    final db = await dbHelper.database;

    return await db.query('sales_order_header', where: 'sync_status IN (0, 2)', orderBy: 'created_at ASC');
  }

  // =====================================================
  // GET SINGLE SALES ORDER (BY LOCAL ID)
  // =====================================================
  Future<SalesOrderPayloadModel?> getSalesOrderByLocalId(int localId) async {
    final db = await dbHelper.database;

    final result = await db.query('sales_order_header', where: 'local_id = ?', whereArgs: [localId]);

    if (result.isEmpty) return null;

    final row = result.first;

    return _mapRowToModel(row);
  }

  // =====================================================
  // UPDATE SYNC ERROR
  // =====================================================
  Future<void> markSyncError(int localId, String errorMessage) async {
    final db = await dbHelper.database;

    await db.update('sales_order_header', {'sync_status': 2, 'sync_error': errorMessage}, where: 'local_id = ?', whereArgs: [localId]);
  }

  // =====================================================
  // SYNC SUCCESS → DELETE DATA
  // =====================================================
  Future<void> deleteAfterSyncSuccess(int localId) async {
    final db = await dbHelper.database;

    await db.delete('sales_order_header', where: 'local_id = ?', whereArgs: [localId]);
  }

  // =====================================================
  // CLEAR ALL SALES ORDERS (DEBUG / RESET)
  // =====================================================
  Future<int> clearAll() async {
    final db = await dbHelper.database;
    return await db.delete('sales_order_header');
  }

  // =====================================================
  // PRIVATE MAPPER
  // =====================================================
  SalesOrderPayloadModel _mapRowToModel(Map<String, dynamic> row) {
    final List<SalesOrderDetail> details = (jsonDecode(row['details_json']) as List).map((e) => SalesOrderDetail.fromJson(e)).toList();

    return SalesOrderPayloadModel(
      salesOrderDate: row['sales_order_date'],
      customerId: row['customer_id'],
      areaId: row['area_id'],
      salesId: row['sales_id'],
      paymentType: row['payment_type'],
      sourceId: row['source_id'],
      warehouseId: row['warehouse_id'],
      currencyId: row['currency_id'],
      rate: row['rate'],
      subTotal: row['sub_total'],
      discount: row['discount'],
      total: row['total'],
      grandTotal: row['grand_total'],
      notes: row['notes'],
      isVoid: row['is_void'],
      status: row['status'],
      destinationAddress: row['destination_address'],
      salesType: row['sales_type'],
      userRecord: row['user_record'],
      details: details,
    );
  }
}
