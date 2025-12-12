enum PaymentType { quickSalesPayment, salesOrderPayment, returnPayment, outstandingOrderPayment }

extension PaymentTypeExtension on PaymentType {
  String get value {
    switch (this) {
      case PaymentType.quickSalesPayment:
        return 'QuickSalesPayment';
      case PaymentType.salesOrderPayment:
        return 'SalesOrderPayment';
      case PaymentType.returnPayment:
        return 'ReturnPayment';
      case PaymentType.outstandingOrderPayment:
        return 'OutstandingOrderPayment';
    }
  }

  String get label {
    switch (this) {
      case PaymentType.quickSalesPayment:
        return 'Quick Sales Payment';
      case PaymentType.salesOrderPayment:
        return 'Sales Order Payment';
      case PaymentType.returnPayment:
        return 'Return Payment';
      case PaymentType.outstandingOrderPayment:
        return 'Outstanding Order Payment';
    }
  }

  static PaymentType? fromValue(String value) {
    switch (value) {
      case 'QuickSalesPayment':
        return PaymentType.quickSalesPayment;
      case 'SalesOrderPayment':
        return PaymentType.salesOrderPayment;
      case 'ReturnPayment':
        return PaymentType.returnPayment;
      case 'OutstandingOrderPayment':
        return PaymentType.outstandingOrderPayment;
      default:
        return null;
    }
  }
}
