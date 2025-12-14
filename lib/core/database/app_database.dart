// ignore_for_file: depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();
  static Database? _database;

  static const int dbVersion = 15;

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
    await _createQuickSalesHeaderTable(db);
    await _createSalesOrderTable(db);
    await _createSalesReturnTable(db);
    await _createCustomerUploadFotoTable(db);
    await _createShippingSalesOrderTable(db);
    await _createPattyCashTable(db);
    await _createActivityHistoryTable(db);
    await _createOutstandingPaymentTable(db);
    await createOutstandingSalesOrderTable(db);
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
    if (oldVersion < 7) {
      await _createQuickSalesHeaderTable(db);
    }
    if (oldVersion < 8) {
      await _createSalesOrderTable(db);
    }
    if (oldVersion < 9) {
      await _createSalesReturnTable(db);
    }
    if (oldVersion < 10) {
      await _createCustomerUploadFotoTable(db);
    }
    if (oldVersion < 11) {
      await _createShippingSalesOrderTable(db);
    }
    if (oldVersion < 12) {
      await _createPattyCashTable(db);
    }
    if (oldVersion < 13) {
      await _createActivityHistoryTable(db);
    }
    if (oldVersion < 14) {
      await _createOutstandingPaymentTable(db);
    }
    if (oldVersion < 15) {
      await createOutstandingSalesOrderTable(db);
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

  // Quick Sales
  Future _createQuickSalesHeaderTable(Database db) async {
    await db.execute("""
    CREATE TABLE IF NOT EXISTS quick_sales_header (
      local_id INTEGER PRIMARY KEY AUTOINCREMENT,

      quick_sales_date TEXT,
      customer_id TEXT,
      area_id TEXT,
      sales_id TEXT,
      payment_type INTEGER,
      source_id TEXT,
      warehouse_id TEXT,
      currency_id TEXT,

      rate REAL,
      sub_total REAL,
      discount REAL,
      total REAL,
      grand_total REAL,

      slip_id TEXT,
      sales_return_id TEXT,
      sales_return_payment REAL,
      remaining_payment REAL,

      notes TEXT,
      is_void INTEGER,
      status INTEGER,
      destination_address TEXT,
      sales_type INTEGER,
      user_record TEXT,

      -- DETAIL DISIMPAN JSON
      details_json TEXT,

      -- SYNC CONTROL
      sync_status INTEGER DEFAULT 0, -- 0 pending, 1 success, 2 error
      sync_error TEXT,
      created_at TEXT,
      synced_at TEXT
    )
  """);
  }

  // Sales Order
  Future _createSalesOrderTable(Database db) async {
    await db.execute("""
    CREATE TABLE IF NOT EXISTS sales_order_header (
      local_id INTEGER PRIMARY KEY AUTOINCREMENT,
      sales_order_date TEXT,
      customer_id TEXT,
      area_id TEXT,
      sales_id TEXT,
      payment_type INTEGER,
      source_id TEXT,
      warehouse_id TEXT,
      currency_id TEXT,

      rate REAL,
      sub_total REAL,
      discount REAL,
      total REAL,
      grand_total REAL,

      notes TEXT,
      is_void INTEGER,
      status INTEGER,
      destination_address TEXT,
      sales_type INTEGER,
      user_record TEXT,

      -- DETAIL DISIMPAN JSON
      details_json TEXT,

      -- SYNC CONTROL
      sync_status INTEGER DEFAULT 0, -- 0 pending, 1 success, 2 error
      sync_error TEXT,
      created_at TEXT,
      synced_at TEXT
    )
  """);
  }

  // Sales Return
  Future _createSalesReturnTable(Database db) async {
    await db.execute("""
    CREATE TABLE IF NOT EXISTS sales_return_header (
      local_id INTEGER PRIMARY KEY AUTOINCREMENT,
      sales_return_date TEXT,
      customer_id TEXT,
      area_id TEXT,
      sales_id TEXT,
      payment_type INTEGER,
      source_id TEXT,
      warehouse_id TEXT,
      currency_id TEXT,

      rate REAL,
      sub_total REAL,
      discount REAL,
      total REAL,
      grand_total REAL,

      notes TEXT,
      is_void INTEGER,
      status INTEGER,
      destination_address TEXT,
      sales_type INTEGER,
      user_record TEXT,

      -- DETAIL DISIMPAN JSON
      details_json TEXT,

      -- SYNC CONTROL
      sync_status INTEGER DEFAULT 0, -- 0 pending, 1 success, 2 error
      sync_error TEXT,
      created_at TEXT,
      synced_at TEXT
    )
  """);
  }

  // Upload Foto
  Future _createCustomerUploadFotoTable(Database db) async {
    await db.execute("""
    CREATE TABLE IF NOT EXISTS customer_upload_foto (
      local_id INTEGER PRIMARY KEY AUTOINCREMENT,
      latitude TEXT,
      longitude TEXT,
      address TEXT,
      status_visit INTEGER,
      user_modified TEXT,
      visit_date TEXT,
      image_base64 TEXT,
      is_synced INTEGER DEFAULT 0,
      sync_error TEXT,
      created_at TEXT
    )
  """);
  }

  // shipping sales orders
  Future _createShippingSalesOrderTable(Database db) async {
    await db.execute('''
      CREATE TABLE shipping_sales_orders (
        local_id INTEGER PRIMARY KEY AUTOINCREMENT,

        sales_order_id TEXT NOT NULL,
        user_record TEXT NOT NULL,

        -- SYNC CONTROL
        sync_status INTEGER DEFAULT 0, 
        -- 0 = pending
        -- 1 = synced (optional, biasanya langsung delete)
        -- 2 = error

        sync_error TEXT,

        created_at TEXT NOT NULL
      )
      ''');
  }

  // Patty Cash
  Future _createPattyCashTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS patty_cash (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sisaSaldo REAL
      )
    ''');
  }

  // activity history
  Future _createActivityHistoryTable(Database db) async {
    await db.execute('''
  CREATE TABLE activity_history_transactions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,

    customer_id TEXT NOT NULL,

    sales_id TEXT NOT NULL,
    transaction_date TEXT NOT NULL,

    shipping_id TEXT,
    last_update TEXT,

    total_qty INTEGER,
    total_qty2 INTEGER,

    grand_total REAL NOT NULL,

    transaction_type TEXT NOT NULL,
    flag_paid INTEGER NOT NULL,

    inventory_names TEXT,

    created_at TEXT NOT NULL
  )
  ''');
  }

  //OutstandingPayment
  Future _createOutstandingPaymentTable(Database db) async {
    await db.execute('''
    CREATE TABLE outstanding_payments (
      local_id INTEGER PRIMARY KEY AUTOINCREMENT,

      invoice_id TEXT NOT NULL,
      slip_id TEXT NOT NULL,

      sales_return_id TEXT,
      sales_return_payment REAL NOT NULL,

      remaining_payment REAL NOT NULL,

      user_record TEXT NOT NULL,

      -- SYNC CONTROL
      sync_status INTEGER DEFAULT 0,
      -- 0 = pending
      -- 1 = synced (optional, biasanya langsung delete)
      -- 2 = error

      sync_error TEXT,

      created_at TEXT NOT NULL
    )
  ''');
  }

  // Outstanding Sales Order
  Future createOutstandingSalesOrderTable(Database db) async {
    await db.execute('''
    CREATE TABLE outstandingsalesorder (
      sales_order_id TEXT PRIMARY KEY,
      sales_order_date TEXT NOT NULL,
      customer_id TEXT NOT NULL,

      shipping_id TEXT,
      invoice_id TEXT,

      total_qty INTEGER NOT NULL,
      inventory_names TEXT NOT NULL,

      is_shipped INTEGER NOT NULL,
      is_paid INTEGER NOT NULL,

      grand_total_shipping TEXT,
      grand_total_invoice TEXT,
      total_payment TEXT
    )
  ''');
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
