import 'package:sail_in_co/data/models/customer/upload_foto/customer_upload_foto_request.dart';
import '../../../core/database/app_database.dart';

class CustomerUploadFotoDao {
  final dbHelper = AppDatabase.instance;

  /// ===============================
  /// SAVE OFFLINE FOTO VISIT
  /// ===============================
  Future<int> save({
    required CustomerUploadFotoRequest payload,
    required String imageBase64,
  }) async {
    final db = await dbHelper.database;

    return db.insert(
      'customer_upload_foto',
      {
        'latitude': payload.latitude,
        'longitude': payload.longitude,
        'address': payload.address,
        'status_visit': payload.statusVisit,
        'user_modified': payload.userModified,
        'visit_date': payload.visitDate.toIso8601String(),
        'image_base64': imageBase64,
        'is_synced': 0,
        'created_at': DateTime.now().toIso8601String(),
      },
    );
  }

  /// ===============================
  /// GET DATA BELUM SYNC
  /// ===============================
  Future<List<Map<String, dynamic>>> getPendingUploads() async {
    final db = await dbHelper.database;

    return db.query(
      'customer_upload_foto',
      where: 'is_synced = ?',
      whereArgs: [0],
      orderBy: 'created_at ASC',
    );
  }

  /// ===============================
  /// MARK SUCCESS SYNC
  /// ===============================
  Future<void> markSynced(int localId) async {
    final db = await dbHelper.database;

    await db.update(
      'customer_upload_foto',
      {
        'is_synced': 1,
        'sync_error': null,
      },
      where: 'local_id = ?',
      whereArgs: [localId],
    );
  }

  /// ===============================
  /// MARK SYNC ERROR
  /// ===============================
  Future<void> markSyncError(int localId, String error) async {
    final db = await dbHelper.database;

    await db.update(
      'customer_upload_foto',
      {
        'sync_error': error,
      },
      where: 'local_id = ?',
      whereArgs: [localId],
    );
  }

  /// ===============================
  /// DELETE AFTER SUCCESS (OPTIONAL)
  /// ===============================
  Future<int> deleteAfterSync(int localId) async {
    final db = await dbHelper.database;

    return db.delete(
      'customer_upload_foto',
      where: 'local_id = ?',
      whereArgs: [localId],
    );
  }
}
