enum  PaymentType { quickSalesPayment, salesOrderPayment, returnPayment }

extension PaymentTypeExtension on PaymentType {
  String get value {
    switch (this) {
      case PaymentType.quickSalesPayment:
        return 'QuickSalesPayment';
      case PaymentType.salesOrderPayment:
        return 'SalesOrderPayment';
      case PaymentType.returnPayment:
        return 'ReturnPayment';
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
      default:
        return null;
    }
  }
}
