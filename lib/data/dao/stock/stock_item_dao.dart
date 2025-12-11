import 'package:sail_in_co/data/models/stock/stock_response.dart';
import 'package:sqflite/sqflite.dart';
import '../../../core/database/app_database.dart';

class StockItemDao {
  final dbHelper = AppDatabase.instance;

  /// Hapus semua lalu insert list baru (sync fresh)
  Future<void> saveStockItems(List<StockItem> items) async {
    final db = await dbHelper.database;

    // Delete old data first
    await db.delete("stock_items");

    // Insert new data
    for (var item in items) {
      await db.insert("stock_items", {
        "inventory_id": item.inventoryId,
        "inventory_name": item.inventoryName,
        "warehouse_id": item.warehouseId,
        "warehouse_name": item.warehouseName,
        "total_stock": item.totalStock,
        "uom_name": item.uomName,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  /// Get all offline data
  Future<List<StockItem>> getStockItems() async {
    final db = await dbHelper.database;
    final result = await db.query("stock_items");

    return result.map((row) {
      return StockItem(
        inventoryId: row["inventory_id"] as String?,
        inventoryName: row["inventory_name"] as String?,
        warehouseId: row["warehouse_id"] as String?,
        warehouseName: row["warehouse_name"] as String?,
        totalStock: row["total_stock"] as int?,
        uomName: row["uom_name"] as String?,
      );
    }).toList();
  }
}
