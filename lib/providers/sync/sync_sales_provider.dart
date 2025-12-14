// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:sail_in_co/data/dao/sales/quick_sales_dao.dart';
// import 'package:sail_in_co/data/models/quicksales/quick_sales_payload_model.dart';
// import 'package:sail_in_co/data/repositories/payment_repository.dart';

// import '../../data/models/quicksales/quick_sales_detail_model.dart';

// class SyncSalesProvider extends ChangeNotifier {
//   final repoPayment = PaymentRepository();
//   final daoQuickSales = QuickSalesDao();

//   bool isSyncing = false;
//   int totalPending = 0;
//   int syncedCount = 0;
//   String? lastError;

//   // =====================================================
//   // SYNC SEMUA QUICK SALES LOCAL
//   // =====================================================
//   Future<void> syncLocalQuickSales() async {
//     if (isSyncing) return;

//     isSyncing = true;
//     syncedCount = 0;
//     lastError = null;
//     notifyListeners();

//     try {
//       final pendingRows = await daoQuickSales.getPendingQuickSales();
//       totalPending = pendingRows.length;
//       notifyListeners();

//       for (final row in pendingRows) {
//         final localId = row['local_id'] as int;

//         try {
//           // ===============================
//           // DECODE DETAIL JSON
//           // ===============================
//           final List<QuickSalesDetailModel> details = (jsonDecode(row['details_json']) as List).map((e) => QuickSalesDetailModel.fromJson(e)).toList();

//           // ===============================
//           // BUILD MODEL (FULLY TYPED)
//           // ===============================
//           final payload = QuickSalesPayloadModel(
//             quickSalesDate: row['quick_sales_date'],
//             customerId: row['customer_id'],
//             areaId: row['area_id'],
//             salesId: row['sales_id'],
//             paymentType: row['payment_type'],
//             sourceId: row['source_id'],
//             warehouseId: row['warehouse_id'],
//             currencyId: row['currency_id'],
//             rate: row['rate'],
//             subTotal: row['sub_total'],
//             discount: row['discount'],
//             total: row['total'],
//             grandTotal: row['grand_total'],
//             slipId: row['slip_id'],
//             salesReturnId: row['sales_return_id'],
//             salesReturnPayment: row['sales_return_payment'],
//             remainingPayment: row['remaining_payment'],
//             notes: row['notes'],
//             isVoid: row['is_void'],
//             status: row['status'],
//             destinationAddress: row['destination_address'],
//             salesType: row['sales_type'],
//             userRecord: row['user_record'],
//             details: details,
//           );

//           // ===============================
//           // POST KE SERVER
//           // ===============================
//           final res = await repoPayment.postQuickSales(payload: payload);

//           if (res.statusCode == 201 && res.data != null) {
//             // ✅ SUKSES → HAPUS DATA LOKAL
//             await daoQuickSales.deleteAfterSyncSuccess(localId);
//             syncedCount++;
//             notifyListeners();
//           } else {
//             // ❌ API ERROR
//             await daoQuickSales.markSyncError(localId, res.message ?? 'Sync failed (${res.statusCode})');
//           }
//         } catch (e) {
//           // ❌ NETWORK / PARSE ERROR
//           await daoQuickSales.markSyncError(localId, e.toString());
//         }
//       }
//     } finally {
//       isSyncing = false;
//       notifyListeners();
//     }
//   }

//   // =====================================================
//   // OPTIONAL: AUTO SYNC ON APP START / RESUME
//   // =====================================================
//   Future<void> tryAutoSync() async {
//     try {
//       await syncLocalQuickSales();
//     } catch (_) {}
//   }
// }
