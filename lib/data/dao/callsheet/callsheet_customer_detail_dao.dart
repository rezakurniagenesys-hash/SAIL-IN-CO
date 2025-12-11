import 'package:sail_in_co/data/models/customer/customer_detail_response.dart';
import 'package:sqflite/sqflite.dart';
import '../../../core/database/app_database.dart';

class CustomerDetailDao {
  final dbHelper = AppDatabase.instance;

  /// Save detail customer (insert or replace)
  Future<void> saveCustomerDetail(CustomerModel? item) async {
    final db = await dbHelper.database;

    await db.insert("customer_detail", {
      "no_acc6": item?.noAcc6 ?? "",
      "name": item?.name,
      "address": item?.address,
      "phone": item?.phone,
      "province": item?.province,
      "city": item?.city,
      "district": item?.district,
      "sub_district": item?.subDistrict,
      "nik": item?.nik,
      "credit_limit": item?.creditLimit,
      "default_payment": item?.defaultPayment,
      "area_id": item?.areaId,
      "type_customer": item?.typeCustomer,
      "area_name": item?.areaName,
      "status_visit": item?.statusVisit,
      "link_path": item?.linkPath,
      "latitude": item?.latitude,
      "longitude": item?.longitude,
      "visit_address": item?.visitAddress,
      "visit_date": item?.visitDate?.toIso8601String(),
      "reason": item?.reason,
      "visit_notes": item?.visitNotes ?? '',
      "photo_id_card": item?.photoIdCard ?? '',
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// Get customer detail by ID
  Future<CustomerModel?> getCustomerDetail(String noAcc6) async {
    final db = await dbHelper.database;

    final result = await db.query("customer_detail", where: "no_acc6 = ?", whereArgs: [noAcc6]);

    if (result.isEmpty) return null;

    final row = result.first;

    return CustomerModel(
      noAcc6: row["no_acc6"] as String?,
      name: row["name"] as String?,
      address: row["address"] as String?,
      phone: row["phone"] as String?,
      province: row["province"] as String?,
      city: row["city"] as String?,
      district: row["district"] as String?,
      subDistrict: row["sub_district"] as String?,
      nik: row["nik"] as String?,
      creditLimit: row["credit_limit"] as String?,
      defaultPayment: row["default_payment"] as String?,
      areaId: row["area_id"] as String?,
      typeCustomer: row["type_customer"] as String?,
      areaName: row["area_name"] as String?,
      statusVisit: row["status_visit"] as int?,
      linkPath: row["link_path"] as String?,
      latitude: row["latitude"] as String?,
      longitude: row["longitude"] as String?,
      visitAddress: row["visit_address"] as String?,
      visitDate: row["visit_date"] != null ? DateTime.tryParse(row["visit_date"] as String) : null,
      reason: row["reason"] as String?,
      visitNotes: row["visit_notes"] as String?,
      photoIdCard: row["photo_id_card"] as String?,
    );
  }

  /// Delete detail customer
  Future<int> deleteCustomerDetail(String noAcc6) async {
    final db = await dbHelper.database;
    return db.delete("customer_detail", where: "no_acc6 = ?", whereArgs: [noAcc6]);
  }

  // delete all
  Future<int> deleteAllCustomerDetails() async {
    final db = await dbHelper.database;
    return db.delete("customer_detail");
  }

  /// Clear all details
  Future<int> clearAll() async {
    final db = await dbHelper.database;
    return db.delete("customer_detail");
  }
}
