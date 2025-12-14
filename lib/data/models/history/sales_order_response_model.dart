import 'package:json_annotation/json_annotation.dart';

part 'sales_order_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SalesOrderResponseModel {
  final bool success;
  final String message;
  final SalesOrderDataWrapper data;

  SalesOrderResponseModel({required this.success, required this.message, required this.data});

  factory SalesOrderResponseModel.fromJson(Map<String, dynamic> json) => _$SalesOrderResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalesOrderResponseModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SalesOrderDataWrapper {
  final List<SalesOrderModel> data;
  final int total;
  final int page;
  final int limit;

  @JsonKey(name: 'totalPages')
  final int totalPages;

  SalesOrderDataWrapper({required this.data, required this.total, required this.page, required this.limit, required this.totalPages});

  factory SalesOrderDataWrapper.fromJson(Map<String, dynamic> json) => _$SalesOrderDataWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$SalesOrderDataWrapperToJson(this);
}

@JsonSerializable()
class SalesOrderModel {
  @JsonKey(name: 'sales_order_id')
  final String salesOrderId;

  @JsonKey(name: 'sales_order_date')
  final String salesOrderDate;

  @JsonKey(name: 'customer_id')
  final String customerId;

  @JsonKey(name: 'shipping_id')
  final String? shippingId;

  @JsonKey(name: 'invoice_id')
  final String? invoiceId;

  @JsonKey(name: 'total_qty')
  final int totalQty;

  @JsonKey(name: 'inventory_names')
  final String inventoryNames;

  @JsonKey(name: 'is_shipped')
  final int isShipped;

  @JsonKey(name: 'is_paid')
  final int isPaid;

  @JsonKey(name: 'grand_total_shipping')
  final dynamic grandTotalShipping;

  @JsonKey(name: 'grand_total_invoice')
  final dynamic grandTotalInvoice;

  @JsonKey(name: 'total_payment')
  final dynamic totalPayment;

  SalesOrderModel({
    required this.salesOrderId,
    required this.salesOrderDate,
    required this.customerId,
    required this.totalQty,
    required this.inventoryNames,
    required this.isShipped,
    required this.isPaid,
    this.shippingId,
    this.invoiceId,
    this.grandTotalShipping,
    this.grandTotalInvoice,
    this.totalPayment,
  });

  factory SalesOrderModel.fromJson(Map<String, dynamic> json) => _$SalesOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalesOrderModelToJson(this);
}
