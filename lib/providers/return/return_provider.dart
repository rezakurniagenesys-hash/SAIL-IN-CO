// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sail_in_co/core/constants/constant_date.dart';
import 'package:sail_in_co/core/utils/connection_utils.dart';
import 'package:sail_in_co/core/utils/date_utils.dart';
import 'package:sail_in_co/data/dao/sales/sales_return_dao.dart';
import 'package:sail_in_co/data/models/auth/auth_response_model.dart';
import 'package:sail_in_co/data/models/customer/customer_detail_response.dart';
import 'package:sail_in_co/data/models/general/order/general_order_draft_item.dart';
import 'package:sail_in_co/data/models/salesorder/sales_order_detail.dart';
import 'package:sail_in_co/data/models/salesorder/sales_order_payload_model.dart';
import 'package:sail_in_co/data/models/salesorder/sales_return_payment_payload.dart';
import 'package:sail_in_co/data/repositories/sales_repository.dart';
import 'package:sail_in_co/services/auth_service.dart';

class ReturnProvider extends ChangeNotifier {
  final salesRepository = SalesRepository();
  final daoSalesReturn = SalesReturnDao();

  List<GeneralOrderDraftItem> returnOrderItems = [];
  TextEditingController notesController = TextEditingController();
  UserInfo? userInfo;
  CustomerDetailData? customerDetailData;

  bool isLoadingSubmit = false;
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

    for (var item in returnOrderItems) {
      final int qty = item.qty2;
      final int discount = item.discount;
      total += qty * discount;
    }

    return total;
  }

  int subTotal() {
    int total = 0;

    for (var item in returnOrderItems) {
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

    for (var item in returnOrderItems) {
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

  void addReturnOrderItem(GeneralOrderDraftItem item) {
    returnOrderItems.add(item);
    notifyListeners();
  }

  void updateReturnOrderItem(int index, GeneralOrderDraftItem item) {
    if (index >= 0 && index < returnOrderItems.length) {
      returnOrderItems[index] = item;
      notifyListeners();
    }
  }

  void removeReturnOrderItem(int index) {
    if (index >= 0 && index < returnOrderItems.length) {
      returnOrderItems.removeAt(index);
      notifyListeners();
    }
  }

  void clearReturnOrderItems() {
    returnOrderItems.clear();
    notifyListeners();
  }

  void submit(BuildContext context) async {
    isLoadingSubmit = true;
    notifyListeners();
    final userInfo = await AuthService.getUserInfo();
    SalesReturnPaymentPayload returnOrderPayloadModel = SalesReturnPaymentPayload(
      salesReturnDate: DateUtilsHelper.formatYMD(DateTime.now()),
      customerId: customerDetailData?.customer?.noAcc6 ?? '',
      areaId: customerDetailData?.customer?.areaId ?? '',
      salesId: userInfo?.userId ?? '',
      paymentType: 0,
      sourceId: 'SOU.001',
      warehouseId: userInfo?.userId ?? '',
      currencyId: 'IDR',
      rate: 1, // Hardcoded Quick Sales
      subTotal: subTotal(),
      discount: totalDiscount(),
      total: grandTotal(),
      grandTotal: grandTotal(),
      notes: notesController.text,
      isVoid: 0, // Hardcoded Quick Sales
      status: 1,
      destinationAddress: customerDetailData?.customer?.address ?? '',
      salesType: 1, // Hardcoded Quick Sales
      userRecord: userInfo?.username ?? '',
      details: returnOrderItems.map((e) {
        // index 1 + 1 sesuai jumalh data
        final index = returnOrderItems.indexOf(e) + 1;
        return SalesOrderDetail(
          index: index,
          inventoryId: e.inventory.inventoryId,
          uomId: e.uom_id,
          qty: e.qty,
          price: e.price,
          voidValue: 0,
          uomId2: e.uom_id2,
          qty2: e.qty2,
          price2: e.price,
          vatValue: 0,
          discValue: (e.discount * e.qty2),
          subTotal: e.sub_total,
          grandTotal: e.grand_total,
          notes: e.notes,
          userRecord: userInfo?.username ?? '',
        );
      }).toList(),
    );

    log("Sales Order Payload: ${returnOrderPayloadModel.toJson()}");
    final online = await ConnectionUtils.isConnected();
    try {
      if (online) {
        final res = await salesRepository.potstSalesReturn(payload: returnOrderPayloadModel);

        if ((res.statusCode == 201) && res.data != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Berhasil pengembalian pembayaran penjualan.'), backgroundColor: Colors.green));
          Navigator.of(context).pop('refresh-return-payment');
        } else if (res.statusCode == 502) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bad gateway.'), backgroundColor: Colors.red));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.message ?? 'Unknown error'), backgroundColor: Colors.red));
        }
      } else {
        await daoSalesReturn.saveSalesReturn(returnOrderPayloadModel);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Berhasil pengembalian pembayaran penjualan secara lokal.'), backgroundColor: Colors.green));
        Navigator.of(context).pop('refresh-return-payment');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error fetching payment method data: $e'), backgroundColor: Colors.red));
    } finally {
      isLoadingSubmit = false;
      notifyListeners();
    }

    notifyListeners();
  }
}
