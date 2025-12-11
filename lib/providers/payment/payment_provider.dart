// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sail_in_co/data/models/payment/payment_method_response.dart';
import 'package:sail_in_co/data/models/quicksales/quick_sales_payload_model.dart';
import 'package:sail_in_co/data/models/sales/sales_return_response.dart';
import 'package:sail_in_co/data/repositories/payment_repository.dart';
import 'package:sail_in_co/services/auth_service.dart';

class PaymentProvider extends ChangeNotifier {
  final repository = PaymentRepository();

  QuickSalesPayloadModel? quickSalesPayloadModel;

  bool isLoading = false;
  bool isLoadingSubmit = false;
  List<SalesReturnData> salesReturnData = [];
  List<PaymentMethodData> paymentMethodData = [];

  PaymentMethodData? selectedPaymentMethod;
  SalesReturnData? selectedSalesReturn;

  num remainingPayment = 0;

  Future<void> init(BuildContext context, String customerId) async {
    isLoading = true;
    clearSelection();
    notifyListeners();

    await getSalesReturn(context, customerId);
    await getPaymentMethod(context);

    isLoading = false;
    notifyListeners();
  }

  void setSelectedPaymentMethod(PaymentMethodData? method) {
    selectedPaymentMethod = method;
    notifyListeners();
  }

  void setSelectedSalesReturn(SalesReturnData? salesReturn) {
    selectedSalesReturn = salesReturn;
    final num sisaValue = num.tryParse(salesReturn?.sisa ?? '0') ?? 0;

    remainingPayment = remainingPayment - sisaValue;

    notifyListeners();
  }

  void setQuickSalesPayloadModel(QuickSalesPayloadModel? model) {
    quickSalesPayloadModel = model;
    remainingPayment = model?.grandTotal ?? 0;
    notifyListeners();
  }

  Future<void> getSalesReturn(BuildContext context, String customerId) async {
    try {
      final res = await repository.getSalesReturns(customerId: customerId);

      if (res.statusCode == 200 && res.data != null) {
        final responseSalesReturn = SalesReturnResponse.fromJson(res.data);
        salesReturnData = responseSalesReturn.data;
      } else if (res.statusCode == 502) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bad gateway.'), backgroundColor: Colors.red));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.message ?? 'Unknown error'), backgroundColor: Colors.red));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error fetching sales return data: $e'), backgroundColor: Colors.red));
    }
  }

  Future<void> getPaymentMethod(BuildContext context) async {
    final userInfo = await AuthService.getUserInfo();
    try {
      final res = await repository.getPaymentMethods(noAcc6: userInfo?.userId ?? '');

      if (res.statusCode == 200 && res.data != null) {
        final responsePaymentMethod = PaymentMethodResponse.fromJson(res.data);
        paymentMethodData = responsePaymentMethod.data;
      } else if (res.statusCode == 502) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bad gateway.'), backgroundColor: Colors.red));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.message ?? 'Unknown error'), backgroundColor: Colors.red));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error fetching payment method data: $e'), backgroundColor: Colors.red));
    }
  }

  void clearSelection() {
    selectedPaymentMethod = null;
    selectedSalesReturn = null;
    remainingPayment = quickSalesPayloadModel?.grandTotal ?? 0;
    notifyListeners();
  }

  void confirmPayment(BuildContext context) async {
    isLoadingSubmit = true;
    notifyListeners();
    final newPayload = quickSalesPayloadModel?.copyWith(
      remainingPayment: remainingPayment,
      slipId: selectedPaymentMethod?.slipId ?? '',
      salesReturnId: selectedSalesReturn?.salesReturnId ?? '',
      salesReturnPayment: num.tryParse(selectedSalesReturn?.sisa ?? '0') ?? 0,
      sourceId: 'SOU.001',
    );
    log('Confirmed Payment with Payload: ${newPayload?.toJson()}');

    try {
      final res = await repository.postQuickSales(payload: newPayload!);

      if ((res.statusCode == 201) && res.data != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment confirmed successfully.'), backgroundColor: Colors.green));
        Navigator.of(context).pop();
        Navigator.of(context).pop('refresh-quick-sales');
      } else if (res.statusCode == 502) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bad gateway.'), backgroundColor: Colors.red));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.message ?? 'Unknown error'), backgroundColor: Colors.red));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error fetching payment method data: $e'), backgroundColor: Colors.red));
    } finally {
      isLoadingSubmit = false;
      notifyListeners();
    }
  }
}
