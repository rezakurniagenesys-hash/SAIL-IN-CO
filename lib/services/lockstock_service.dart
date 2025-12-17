import 'package:shared_preferences/shared_preferences.dart';

class LockStockService {
  static const String _prefix = 'LOCK_STOCK_';

  /// Generate key berdasarkan default_id
  static String _key(String defaultId) => '$_prefix${defaultId.replaceAll(' ', '_').toUpperCase()}';

  /// SAVE value (biasanya "true" / "false")
  static Future<void> save({required String defaultId, required String value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key(defaultId), value);
  }

  /// SAVE dari API response (langsung map)
  static Future<void> saveFromApi(List<Map<String, dynamic>> data) async {
    final prefs = await SharedPreferences.getInstance();

    for (final item in data) {
      final defaultId = item['default_id'];
      final value = item['value'];

      if (defaultId != null && value != null) {
        await prefs.setString(_key(defaultId), value.toString());
      }
    }

    print('Saved Lock Stock Settings: ${data.length} items');
  }

  /// GET value (String)
  static Future<String?> get(String defaultId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key(defaultId));
  }

  /// GET value sebagai bool (helper)
  static Future<bool> getBool(String defaultId, {bool defaultValue = false}) async {
    final value = await get(defaultId);
    if (value == null) return defaultValue;
    return value.toLowerCase() == 'true';
  }

  /// DELETE satu default_id
  static Future<void> delete(String defaultId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key(defaultId));
  }

  /// CLEAR semua Lock Stock
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    for (final key in keys) {
      if (key.startsWith(_prefix)) {
        await prefs.remove(key);
      }
    }
  }
}

enum LockStockKey { bukaKunciStockSO, kunciStock }

extension LockStockKeyExt on LockStockKey {
  String get value {
    switch (this) {
      case LockStockKey.bukaKunciStockSO:
        return 'Buka Kunci Stock SO';
      case LockStockKey.kunciStock:
        return 'Kunci Stock';
    }
  }
}


// Contoh penggunaan:

// final isUnlockSO = await LockStockService.getBool(
//   LockStockKey.bukaKunciStockSO.value,
// );

// final isStockLocked = await LockStockService.getBool(
//   LockStockKey.kunciStock.value,
// );