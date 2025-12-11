import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();
  static Database? _database;

  AppDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("app.db");
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // Table offline summary
    await db.execute('''
      CREATE TABLE callsheet_summary (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pending_tasks INTEGER,
        completed_tasks INTEGER,
        total_tasks INTEGER,
        last_update TEXT
      )
    ''');

    // Table stock items
    await db.execute("""
      CREATE TABLE stock_items (
        inventory_id TEXT,
        inventory_name TEXT,
        warehouse_id TEXT,
        warehouse_name TEXT,
        total_stock INTEGER,
        uom_name TEXT
      )
    """);
  }

  Future close() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }
}
