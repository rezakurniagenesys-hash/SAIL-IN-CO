// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sail_in_co/core/utils/connection_utils.dart';
import 'package:sail_in_co/data/dao/master/method_payment_dao.dart';
import 'package:sail_in_co/data/dao/sales/outstanding_payment_dao.dart';
import 'package:sail_in_co/data/dao/sales/quick_sales_dao.dart';
import 'package:sail_in_co/data/models/history/sales_order_response_model.dart';
import 'package:sail_in_co/data/models/payment/payment_method_response.dart';
import 'package:sail_in_co/data/models/quicksales/outstanding_payment_payload_model.dart';
import 'package:sail_in_co/data/models/quicksales/quick_sales_payload_model.dart';
import 'package:sail_in_co/data/models/sales/sales_return_response.dart';
import 'package:sail_in_co/data/repositories/payment_repository.dart';
import 'package:sail_in_co/services/auth_service.dart';
import 'package:sail_in_co/ui/widgets/app_snackbar.dart';

class PaymentProvider extends ChangeNotifier {
  final repository = PaymentRepository();

  QuickSalesPayloadModel? quickSalesPayloadModel;
  SalesOrderModel? salesOrderModel;

  final daoQuickSales = QuickSalesDao();
  final daoMethodPayment = MethodPaymentDao();
  final daoOutstandingPayment = OutstandingPaymentDao();

  bool isLoading = false;
  bool isLoadingSubmit = false;
  List<SalesReturnData> salesReturnData = [];
  List<PaymentMethodData> paymentMethodData = [];

  PaymentMethodData? selectedPaymentMethod;
  SalesReturnData? selectedSalesReturn;

  num remainingPayment = 0;
  num totalPayment = 0;

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

  void setSalesOrderModel(SalesOrderModel? model) {
    salesOrderModel = model;
    totalPayment = int.parse(model?.grandTotalShipping ?? '0');
    remainingPayment = totalPayment;
    notifyListeners();
  }

  void setSelectedSalesReturn(SalesReturnData? salesReturn) {
    selectedSalesReturn = salesReturn;

    final num salesReturnValue = num.tryParse(salesReturn?.sisa ?? '0') ?? 0;

    remainingPayment = totalPayment - salesReturnValue;

    if (remainingPayment < 0) {
      remainingPayment = 0;
    }

    notifyListeners();
  }

  void setQuickSalesPayloadModel(QuickSalesPayloadModel? model) {
    quickSalesPayloadModel = model;
    totalPayment = model?.grandTotal ?? 0;
    remainingPayment = totalPayment;
    notifyListeners();
  }

  Future<void> getSalesReturn(BuildContext context, String customerId) async {
    final online = await ConnectionUtils.isConnected();
    try {
      if (online) {
        final res = await repository.getSalesReturns(customerId: customerId);
        if (res.statusCode == 200 && res.data != null) {
          final responseSalesReturn = SalesReturnResponse.fromJson(res.data);
          salesReturnData = responseSalesReturn.data;
        } else if (res.statusCode == 502) {
          AppSnackBar.show(context, message: 'Bad gateway.', color: Colors.red);
        } else {
          AppSnackBar.show(context, message: res.message ?? 'Unknown error', color: Colors.red);
        }
      }
    } catch (e) {
      AppSnackBar.show(context, message: 'Error fetching sales return data: $e', color: Colors.red);
    }
  }

  Future<void> getPaymentMethod(BuildContext context) async {
    final userInfo = await AuthService.getUserInfo();
    final online = await ConnectionUtils.isConnected();
    try {
      if (online) {
        final res = await repository.getPaymentMethods(noAcc6: userInfo?.userId ?? '');

        if (res.statusCode == 200 && res.data != null) {
          final responsePaymentMethod = PaymentMethodResponse.fromJson(res.data);
          paymentMethodData = responsePaymentMethod.data;
        } else if (res.statusCode == 502) {
          AppSnackBar.show(context, message: 'Bad gateway.', color: Colors.red);
        } else {
          AppSnackBar.show(context, message: res.message ?? 'Unknown error', color: Colors.red);
        }
      } else {
        // OFFLINE HANDLING HERE
        paymentMethodData = await daoMethodPayment.getPaymentMethods();
      }
    } catch (e) {
      AppSnackBar.show(context, message: 'Error fetching payment method data: $e', color: Colors.red);
    }
  }

  void clearSelection() {
    selectedPaymentMethod = null;
    selectedSalesReturn = null;
    remainingPayment = totalPayment;
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
    final online = await ConnectionUtils.isConnected();
    if (selectedPaymentMethod == null) {
      AppSnackBar.show(context, message: 'Pilih metode pembayaran terlebih dahulu.', color: Colors.red);
      isLoadingSubmit = false;
      notifyListeners();
      return;
    }
    try {
      if (online) {
        final res = await repository.postQuickSales(payload: newPayload!);

        if ((res.statusCode == 201) && res.data != null) {
          AppSnackBar.show(context, message: 'Pembayaran berhasil dilakukan.', color: Colors.green);
          Navigator.of(context).pop();
          Navigator.of(context).pop('refresh-quick-sales');
        } else if (res.statusCode == 502) {
          AppSnackBar.show(context, message: 'Bad gateway.', color: Colors.red);
        } else {
          AppSnackBar.show(context, message: res.message ?? 'Unknown error', color: Colors.red);
        }
      } else {
        // OFFLINE HANDLING HERE
        await daoQuickSales.saveQuickSales(newPayload!);
        AppSnackBar.show(context, message: 'Pembayaran berhasil disimpan secara lokal.', color: Colors.green);
        Navigator.of(context).pop();
        Navigator.of(context).pop('refresh-quick-sales');
      }
    } catch (e) {
      AppSnackBar.show(context, message: 'Error fetching payment method data: $e', color: Colors.red);
    } finally {
      isLoadingSubmit = false;
      notifyListeners();
    }
  }

  void submitInvoicePaymentJournal(BuildContext context) async {
    final userInfo = await AuthService.getUserInfo();
    isLoadingSubmit = true;
    notifyListeners();
    OutstandingPaymentPayloadModel newPayload = OutstandingPaymentPayloadModel(
      invoiceId: salesOrderModel?.invoiceId ?? '',
      slipId: selectedPaymentMethod?.slipId ?? '',
      salesReturnId: selectedSalesReturn?.salesReturnId ?? '',
      salesReturnPayment: num.tryParse(selectedSalesReturn?.sisa ?? '0') ?? 0,
      remainingPayment: remainingPayment,
      userRecord: userInfo?.username ?? '',
    );
    final online = await ConnectionUtils.isConnected();
    if (selectedPaymentMethod == null) {
      AppSnackBar.show(context, message: 'Pilih metode pembayaran terlebih dahulu.', color: Colors.red);
      isLoadingSubmit = false;
      notifyListeners();
      return;
    }
    try {
      if (online) {
        final res = await repository.postInvoicePaymentJournal(payload: newPayload);
        if ((res.statusCode == 201) && res.data != null) {
          AppSnackBar.show(context, message: 'Pembayaran berhasil dilakukan.', color: Colors.green);
          Navigator.of(context).pop('refresh-outstanding-order-payment');
        } else if (res.statusCode == 502) {
          AppSnackBar.show(context, message: 'Bad gateway.', color: Colors.red);
        } else {
          AppSnackBar.show(context, message: res.message ?? 'Unknown error', color: Colors.red);
        }
      } else {
        // OFFLINE HANDLING HERE
        await daoOutstandingPayment.saveOutstandingPayment(newPayload);
        AppSnackBar.show(context, message: 'Pembayaran berhasil disimpan secara lokal.', color: Colors.green);
        Navigator.of(context).pop('refresh-outstanding-order-payment');
      }
    } catch (e) {
      AppSnackBar.show(context, message: 'Error fetching payment method data: $e', color: Colors.red);
    } finally {
      isLoadingSubmit = false;
      notifyListeners();
    }
  }
}
