import 'dart:convert';
import 'package:sail_in_co/data/models/general/general_inventory/general_inventory_response.dart';
import 'package:sail_in_co/data/models/general/general_uoms/general_uoms_response.dart';
import 'package:sqflite/sqflite.dart';
import '../../../core/database/app_database.dart';

class InventoryItemDao {
  final dbHelper = AppDatabase.instance;

  /// Save fresh sync: delete all then insert new
  Future<void> saveInventoryItems(List<InventoryItem> items) async {
    final db = await dbHelper.database;

    // Clear old data
    await db.delete("inventory_items");

    // Insert new items
    for (var item in items) {
      await db.insert("inventory_items", {
        "inventory_id": item.inventoryId,
        "inventory_name": item.inventoryName,

        "type_id": item.typeId,
        "type_name": item.typeName,

        "uom_id": item.uomId,
        "uom_name": item.uomName,

        "category_id": item.categoryId,
        "category_name": item.categoryName,

        "variety_id": item.varietyId,
        "variety_name": item.varietyName,

        "brand_id": item.brandId,
        "brand_name": item.brandName,

        "internal_name": item.internalName,

        "rate_price": item.ratePrice,
        "price": item.price,

        "current_stock": item.currentStock?.toString(),

        "stock_warehouse_id": item.stockWarehouseId,
        "stock_warehouse_name": item.stockWarehouseName,
        "stock_uom_name": item.stockUomName,

        // List<UOMItem> → JSON string
        "uoms": item.uoms != null ? jsonEncode(item.uoms!.map((e) => e.toJson()).toList()) : null,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  /// Update current_stock by inventory_id
  Future<int> updateCurrentStock({required String inventoryId, required String currentStock}) async {
    final db = await dbHelper.database;

    return await db.update("inventory_items", {"current_stock": currentStock}, where: "inventory_id = ?", whereArgs: [inventoryId]);
  }

  Future<int> reduceCurrentStock({required String inventoryId, required int qty}) async {
    final db = await dbHelper.database;

    return await db.transaction((txn) async {
      final result = await txn.query("inventory_items", columns: ["current_stock"], where: "inventory_id = ?", whereArgs: [inventoryId], limit: 1);

      if (result.isEmpty) {
        throw Exception("Inventory not found");
      }

      final rawStock = result.first["current_stock"];

      int currentStock;
      if (rawStock is int) {
        currentStock = rawStock;
      } else if (rawStock is double) {
        currentStock = rawStock.toInt();
      } else if (rawStock is String) {
        currentStock = double.tryParse(rawStock)?.toInt() ?? 0;
      } else {
        currentStock = 0;
      }

      final newStock = currentStock - qty;

      if (newStock < 0) {
        throw Exception("Stock not enough");
      }

      return await txn.update("inventory_items", {"current_stock": newStock}, where: "inventory_id = ?", whereArgs: [inventoryId]);
    });
  }

  /// Get all inventory items from SQLite
  Future<List<InventoryItem>> getInventoryItems() async {
    final db = await dbHelper.database;
    final result = await db.query("inventory_items");

    return result.map((row) {
      final uomsJson = row["uoms"] as String?;

      List<UOMItem>? uomList;
      if (uomsJson != null && uomsJson.isNotEmpty) {
        List decoded = jsonDecode(uomsJson);
        uomList = decoded.map((e) => UOMItem.fromJson(e)).toList();
      }

      return InventoryItem(
        inventoryId: row["inventory_id"] as String,
        inventoryName: row["inventory_name"] as String,

        typeId: row["type_id"] as String,
        typeName: row["type_name"] as String,

        uomId: row["uom_id"] as String,
        uomName: row["uom_name"] as String,

        categoryId: row["category_id"] as String,
        categoryName: row["category_name"] as String,

        varietyId: row["variety_id"] as String?,
        varietyName: row["variety_name"] as String?,

        brandId: row["brand_id"] as String?,
        brandName: row["brand_name"] as String?,

        internalName: row["internal_name"] as String?,

        ratePrice: row["rate_price"] as String?,
        price: row["price"] as String?,

        currentStock: row["current_stock"],

        stockWarehouseId: row["stock_warehouse_id"] as String?,
        stockWarehouseName: row["stock_warehouse_name"] as String?,
        stockUomName: row["stock_uom_name"] as String?,

        uoms: uomList,
      );
    }).toList();
  }
}
