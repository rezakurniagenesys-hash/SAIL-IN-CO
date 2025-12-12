// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sail_in_co/core/constants/constant_date.dart';
import 'package:sail_in_co/core/utils/date_utils.dart';
import 'package:sail_in_co/data/models/auth/auth_response_model.dart';
import 'package:sail_in_co/data/models/customer/customer_detail_response.dart';
import 'package:sail_in_co/data/models/general/order/general_order_draft_item.dart';
import 'package:sail_in_co/data/models/quicksales/quick_sales_detail_model.dart';
import 'package:sail_in_co/data/models/quicksales/quick_sales_payload_model.dart';
import 'package:sail_in_co/services/auth_service.dart';
import 'package:sail_in_co/ui/screens/payment/enums/payments_enum.dart';
import 'package:sail_in_co/ui/screens/payment/payment_screen.dart';

class QuickSalesProvider extends ChangeNotifier {
  List<GeneralOrderDraftItem> quickSalesItems = [];
  TextEditingController notesController = TextEditingController();
  UserInfo? userInfo;
  CustomerDetailData? customerDetailData;

  final date = ConstantDate.date;

  Future<void> loadUserInfo() async {
    try {
      userInfo = await AuthService.getUserInfo();
    } catch (e) {
      debugPrint("Error loading user info: $e");
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  void setCustomerDetailData(CustomerDetailData? data) {
    customerDetailData = data;
    notifyListeners();
  }

  void setNotes(String notes) {
    notesController.text = notes;
    notifyListeners();
  }

  int totalDiscount() {
    int total = 0;

    for (var item in quickSalesItems) {
      final int qty = item.qty2;
      final int discount = item.discount;
      total += qty * discount;
    }

    return total;
  }

  int subTotal() {
    int total = 0;

    for (var item in quickSalesItems) {
      final int qty = item.qty2;
      final int price = item.price;
      final int multiplier = int.tryParse(item.uom.value) ?? 1;

      final int sub = qty * multiplier * price;
      total += sub;
    }

    return total;
  }

  int grandTotal() {
    int total = 0;

    for (var item in quickSalesItems) {
      final int qty = item.qty2;
      final int price = item.price;
      final int discount = item.discount;
      final int multiplier = int.tryParse(item.uom.value) ?? 1;

      final int sub = qty * multiplier * price;
      final int totalItem = sub - (qty * discount);

      total += totalItem;
    }

    return total;
  }

  void addQuickSalesItem(GeneralOrderDraftItem item) {
    quickSalesItems.add(item);
    notifyListeners();
  }

  void updateQuickSalesItem(int index, GeneralOrderDraftItem item) {
    if (index >= 0 && index < quickSalesItems.length) {
      quickSalesItems[index] = item;
      notifyListeners();
    }
  }

  void removeQuickSalesItem(int index) {
    if (index >= 0 && index < quickSalesItems.length) {
      quickSalesItems.removeAt(index);
      notifyListeners();
    }
  }

  void clearQuickSalesItems() {
    quickSalesItems.clear();
    notifyListeners();
  }

  void submitPayment(BuildContext context) async {
    final userInfo = await AuthService.getUserInfo();
    QuickSalesPayloadModel quickSalesPayloadModel = QuickSalesPayloadModel(
      quickSalesDate: DateUtilsHelper.formatYMD(DateTime.now()),
      customerId: customerDetailData?.customer?.noAcc6 ?? '',
      areaId: customerDetailData?.customer?.areaId ?? '',
      salesId: userInfo?.userId ?? '',
      paymentType: 0,
      sourceId: userInfo?.sourceId ?? '',
      warehouseId: userInfo?.userId ?? '',
      currencyId: 'IDR',
      rate: 1, // Hardcoded Quick Sales
      subTotal: subTotal(),
      discount: totalDiscount(),
      total: grandTotal(),
      grandTotal: grandTotal(),
      slipId: '', //Ambil dari payment method yang dipilih (response)
      salesReturnId: '', // ambil dar return ID yang dipilih (response)
      salesReturnPayment: 0, // ambil dar return ID yang dipilih (response-> sisa)
      remainingPayment: 0, // hasil calculate
      notes: notesController.text,
      isVoid: 0, // Hardcoded Quick Sales
      status: 1,
      destinationAddress: customerDetailData?.customer?.address ?? '',
      salesType: 1, // Hardcoded Quick Sales
      userRecord: userInfo?.username ?? '',
      details: quickSalesItems.map((e) {
        // index 1 + 1 sesuai jumalh data
        final index = quickSalesItems.indexOf(e) + 1;
        return QuickSalesDetailModel(
          index: index,
          inventoryId: e.inventory.inventoryId,
          uomId: e.uom_id,
          qty: e.qty,
          price: e.price,
          isVoid: 0,
          uomId2: e.uom_id2,
          qty2: e.qty2,
          subTotal: e.sub_total,
          grandTotal: e.grand_total,
          notes: e.notes,
          userRecord: userInfo?.username ?? '',
          price2: e.price,
          vatValue: 0,
          discValue: (e.discount * e.qty2),
        );
      }).toList(),
    );

    log("Quick Sales Payload: ${quickSalesPayloadModel.toJson()}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(paymentType: PaymentType.quickSalesPayment, quickSalesPayloadModel: quickSalesPayloadModel),
      ),
    );
    notifyListeners();
  }
}
