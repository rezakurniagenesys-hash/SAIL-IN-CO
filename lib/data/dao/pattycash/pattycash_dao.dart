import '../../../core/database/app_database.dart';

class PattycashDao {
  final dbHelper = AppDatabase.instance;

  // Insert or update (delete old rows first)
  Future<void> savePattyCash(num sisaSaldo) async {
    final db = await dbHelper.database;

    // Hapus semua row agar tidak terjadi duplikasi
    await db.delete("patty_cash");

    // Insert row baru
    await db.insert("patty_cash", {"sisaSaldo": sisaSaldo});
  }

  // Get single offline patty cash
  Future<num?> getPattyCash() async {
    final db = await dbHelper.database;

    final result = await db.query("patty_cash", limit: 1);

    if (result.isEmpty) return null;

    final row = result.first;

    return row["sisaSaldo"] as num?;
  }
}
