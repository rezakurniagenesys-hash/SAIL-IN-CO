import 'package:sail_in_co/data/models/history/sales_order_response_model.dart';
import 'package:sqflite/sqflite.dart';
import '../../../core/database/app_database.dart';

class OutstandingSalesOrderDao {
  final dbHelper = AppDatabase.instance;

  // =====================================================
  // INSERT / REPLACE (CACHE DARI API)
  // =====================================================
  Future<void> insertAll({required List<SalesOrderModel> items}) async {
    final db = await dbHelper.database;
    final batch = db.batch();

    for (final item in items) {
      batch.insert('outstandingsalesorder', {
        'sales_order_id': item.salesOrderId,
        'sales_order_date': item.salesOrderDate,
        'customer_id': item.customerId,

        'shipping_id': item.shippingId,
        'invoice_id': item.invoiceId,

        'total_qty': item.totalQty,
        'inventory_names': item.inventoryNames,

        'is_shipped': item.isShipped,
        'is_paid': item.isPaid,

        'grand_total_shipping': item.grandTotalShipping?.toString(),
        'grand_total_invoice': item.grandTotalInvoice?.toString(),
        'total_payment': item.totalPayment?.toString(),
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await batch.commit(noResult: true);
  }

  // =====================================================
  // GET ALL OUTSTANDING
  // =====================================================
  Future<List<SalesOrderModel>> getAll() async {
    final db = await dbHelper.database;

    final result = await db.query('outstandingsalesorder', orderBy: 'sales_order_date DESC');

    return result.map(_mapRowToModel).toList();
  }

  // =====================================================
  // GET BY CUSTOMER ID
  // =====================================================
  Future<List<SalesOrderModel>> getByCustomerId({required String customerId, String search = ''}) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'outstandingsalesorder',
      where: '''
        customer_id = ?
        AND (inventory_names LIKE ? OR sales_order_id LIKE ?)
      ''',
      whereArgs: [customerId, '%$search%', '%$search%'],
      orderBy: 'sales_order_date DESC',
    );

    return result.map(_mapRowToModel).toList();
  }

  // =====================================================
  // GET ONLY UNPAID (OUTSTANDING)
  // =====================================================
  Future<List<SalesOrderModel>> getUnpaidByCustomer({required String customerId, String search = ''}) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'outstandingsalesorder',
      where: '''
        customer_id = ?
        AND is_paid = 0
        AND (inventory_names LIKE ? OR sales_order_id LIKE ?)
      ''',
      whereArgs: [customerId, '%$search%', '%$search%'],
      orderBy: 'sales_order_date DESC',
    );

    return result.map(_mapRowToModel).toList();
  }

  // =====================================================
  // CLEAR ALL CACHE
  // =====================================================
  Future<int> clearAll() async {
    final db = await dbHelper.database;
    return await db.delete('outstandingsalesorder');
  }

  // =====================================================
  // CLEAR BY CUSTOMER
  // =====================================================
  Future<int> clearByCustomer(String customerId) async {
    final db = await dbHelper.database;
    return await db.delete('outstandingsalesorder', where: 'customer_id = ?', whereArgs: [customerId]);
  }

  // =====================================================
  // PRIVATE MAPPER
  // =====================================================
  SalesOrderModel _mapRowToModel(Map<String, dynamic> row) {
    return SalesOrderModel(
      salesOrderId: row['sales_order_id'],
      salesOrderDate: row['sales_order_date'],
      customerId: row['customer_id'],

      shippingId: row['shipping_id'],
      invoiceId: row['invoice_id'],

      totalQty: row['total_qty'],
      inventoryNames: row['inventory_names'],

      isShipped: row['is_shipped'],
      isPaid: row['is_paid'],

      grandTotalShipping: row['grand_total_shipping'],
      grandTotalInvoice: row['grand_total_invoice'],
      totalPayment: row['total_payment'],
    );
  }
}
