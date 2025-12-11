// ignore_for_file: depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();
  static Database? _database;

  static const int dbVersion = 6;

  AppDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("app.db");
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(path, version: dbVersion, onCreate: _createDB, onUpgrade: _upgradeDB);
  }

  // ================================================================
  // CREATE TABLES — hanya dipanggil sekali saat database baru dibuat
  // ================================================================
  Future _createDB(Database db, int version) async {
    await _createCallsheetSummaryTable(db);
    await _createStockItemsTable(db);
    await _createInventoryItemsTable(db);
    await _createCustomerTable(db);
    await _createPaymentMethodTable(db);
    await _createCustomerDetailTable(db);
  }

  // ================================================================
  // ON UPGRADE — dipanggil ketika version naik
  // ================================================================
  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await _createStockItemsTable(db);
    }
    if (oldVersion < 3) {
      await _createInventoryItemsTable(db);
    }
    if (oldVersion < 4) {
      await _createCustomerTable(db);
    }
    if (oldVersion < 5) {
      await _createPaymentMethodTable(db);
    }
    if (oldVersion < 6) {
      await _createCustomerDetailTable(db);
    }
  }

  // ================================================================
  // TABLE DEFINITIONS
  // ================================================================

  Future _createCallsheetSummaryTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS callsheet_summary (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pending_tasks INTEGER,
        completed_tasks INTEGER,
        total_tasks INTEGER,
        last_update TEXT
      )
    ''');
  }

  Future _createStockItemsTable(Database db) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS stock_items (
        inventory_id TEXT,
        inventory_name TEXT,
        warehouse_id TEXT,
        warehouse_name TEXT,
        total_stock INTEGER,
        uom_name TEXT
      )
    """);
  }

  Future _createInventoryItemsTable(Database db) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS inventory_items (
        inventory_id TEXT PRIMARY KEY,
        inventory_name TEXT NOT NULL,
        type_id TEXT NOT NULL,
        type_name TEXT NOT NULL,
        uom_id TEXT NOT NULL,
        uom_name TEXT NOT NULL,
        category_id TEXT NOT NULL,
        category_name TEXT NOT NULL,
        variety_id TEXT,
        variety_name TEXT,
        brand_id TEXT,
        brand_name TEXT,
        internal_name TEXT,
        rate_price TEXT,
        price TEXT,
        current_stock REAL,
        stock_warehouse_id TEXT,
        stock_warehouse_name TEXT,
        stock_uom_name TEXT,
        uoms TEXT
      )
    """);
  }

  Future _createCustomerTable(Database db) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS customers (
        no_acc6 TEXT PRIMARY KEY,
        nm_acc6 TEXT,
        address TEXT,
        phone TEXT,
        status_visit INTEGER,
        schedule_id TEXT
      )
    """);
  }

  Future _createPaymentMethodTable(Database db) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS payment_methods (
        slip_id TEXT PRIMARY KEY,
        slip_name TEXT NOT NULL,
        slip_type TEXT NOT NULL,
        currency_id TEXT NOT NULL,
        sales_acc_code TEXT NOT NULL
      )
    """);
  }

  Future _createCustomerDetailTable(Database db) async {
    await db.execute("""
    CREATE TABLE IF NOT EXISTS customer_detail (
      no_acc6 TEXT PRIMARY KEY,
      name TEXT,
      address TEXT,
      phone TEXT,
      province TEXT,
      city TEXT,
      district TEXT,
      sub_district TEXT,
      nik TEXT,
      credit_limit TEXT,
      default_payment TEXT,
      area_id TEXT,
      type_customer TEXT,
      area_name TEXT,
      status_visit INTEGER,
      link_path TEXT,
      latitude TEXT,
      longitude TEXT,
      visit_address TEXT,
      visit_date TEXT,
      reason TEXT,
      visit_notes TEXT,
      photo_id_card TEXT
    )
  """);
  }

  // ================================================================
  // CLOSE DB
  // ================================================================
  Future close() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }
}
