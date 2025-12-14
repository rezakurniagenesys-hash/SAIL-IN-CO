// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sail_in_co/core/constants/constant_date.dart';
import 'package:sail_in_co/core/utils/connection_utils.dart';
import 'package:sail_in_co/core/utils/date_utils.dart';
import 'package:sail_in_co/data/dao/sales/sales_order_dao.dart';
import 'package:sail_in_co/data/models/auth/auth_response_model.dart';
import 'package:sail_in_co/data/models/customer/customer_detail_response.dart';
import 'package:sail_in_co/data/models/general/order/general_order_draft_item.dart';
import 'package:sail_in_co/data/models/salesorder/sales_order_detail.dart';
import 'package:sail_in_co/data/models/salesorder/sales_order_payload_model.dart';
import 'package:sail_in_co/data/repositories/sales_repository.dart';
import 'package:sail_in_co/services/auth_service.dart';

class SalesOrderProvider extends ChangeNotifier {
  final salesRepository = SalesRepository();
  List<GeneralOrderDraftItem> salesOrderItems = [];
  TextEditingController notesController = TextEditingController();
  UserInfo? userInfo;
  CustomerDetailData? customerDetailData;

  final daoSalesOrder = SalesOrderDao();

  bool isLoadingSubmit = false;

  // Date filter - default to today
  final date = ConstantDate.date;

  Future<void> loadUserInfo() async {
    userInfo = await AuthService.getUserInfo();

    Future.microtask(() {
      if (hasListeners) notifyListeners();
    });
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

    for (var item in salesOrderItems) {
      final int qty = item.qty2;
      final int discount = item.discount;
      total += qty * discount;
    }

    return total;
  }

  int subTotal() {
    int total = 0;

    for (var item in salesOrderItems) {
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

    for (var item in salesOrderItems) {
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
    salesOrderItems.add(item);
    notifyListeners();
  }

  void updateQuickSalesItem(int index, GeneralOrderDraftItem item) {
    if (index >= 0 && index < salesOrderItems.length) {
      salesOrderItems[index] = item;
      notifyListeners();
    }
  }

  void removeQuickSalesItem(int index) {
    if (index >= 0 && index < salesOrderItems.length) {
      salesOrderItems.removeAt(index);
      notifyListeners();
    }
  }

  void clearSalesOrderItems() {
    salesOrderItems.clear();
    notifyListeners();
  }

  void submit(BuildContext context) async {
    isLoadingSubmit = true;
    notifyListeners();
    final userInfo = await AuthService.getUserInfo();
    SalesOrderPayloadModel salesOrderPayloadModel = SalesOrderPayloadModel(
      salesOrderDate: DateUtilsHelper.formatYMD(DateTime.now()),
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
      details: salesOrderItems.map((e) {
        // index 1 + 1 sesuai jumalh data
        final index = salesOrderItems.indexOf(e) + 1;
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

    log("Sales Order Payload: ${salesOrderPayloadModel.toJson()}");
    final online = await ConnectionUtils.isConnected();

    try {
      if (online) {
        final res = await salesRepository.postSalesOrder(payload: salesOrderPayloadModel);
        if ((res.statusCode == 201) && res.data != null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Berhasil mengirim sales order.'), backgroundColor: Colors.green));
          Navigator.of(context).pop('refresh-sales-order');
        } else if (res.statusCode == 502) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bad gateway.'), backgroundColor: Colors.red));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.message ?? 'Unknown error'), backgroundColor: Colors.red));
        }
      } else {
        await daoSalesOrder.saveSalesOrder(salesOrderPayloadModel);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Berhasil mengirim sales order ke penyimpanan lokal.'), backgroundColor: Colors.green));
        Navigator.of(context).pop('refresh-sales-order');
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
