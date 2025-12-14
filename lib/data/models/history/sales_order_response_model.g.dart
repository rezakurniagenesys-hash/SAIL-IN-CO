// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_order_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesOrderResponseModel _$SalesOrderResponseModelFromJson(
  Map<String, dynamic> json,
) => SalesOrderResponseModel(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: SalesOrderDataWrapper.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SalesOrderResponseModelToJson(
  SalesOrderResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data.toJson(),
};

SalesOrderDataWrapper _$SalesOrderDataWrapperFromJson(
  Map<String, dynamic> json,
) => SalesOrderDataWrapper(
  data: (json['data'] as List<dynamic>)
      .map((e) => SalesOrderModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
);

Map<String, dynamic> _$SalesOrderDataWrapperToJson(
  SalesOrderDataWrapper instance,
) => <String, dynamic>{
  'data': instance.data.map((e) => e.toJson()).toList(),
  'total': instance.total,
  'page': instance.page,
  'limit': instance.limit,
  'totalPages': instance.totalPages,
};

SalesOrderModel _$SalesOrderModelFromJson(Map<String, dynamic> json) =>
    SalesOrderModel(
      salesOrderId: json['sales_order_id'] as String,
      salesOrderDate: json['sales_order_date'] as String,
      customerId: json['customer_id'] as String,
      totalQty: (json['total_qty'] as num).toInt(),
      inventoryNames: json['inventory_names'] as String,
      isShipped: (json['is_shipped'] as num).toInt(),
      isPaid: (json['is_paid'] as num).toInt(),
      shippingId: json['shipping_id'] as String?,
      invoiceId: json['invoice_id'] as String?,
      grandTotalShipping: json['grand_total_shipping'],
      grandTotalInvoice: json['grand_total_invoice'],
      totalPayment: json['total_payment'],
    );

Map<String, dynamic> _$SalesOrderModelToJson(SalesOrderModel instance) =>
    <String, dynamic>{
      'sales_order_id': instance.salesOrderId,
      'sales_order_date': instance.salesOrderDate,
      'customer_id': instance.customerId,
      'shipping_id': instance.shippingId,
      'invoice_id': instance.invoiceId,
      'total_qty': instance.totalQty,
      'inventory_names': instance.inventoryNames,
      'is_shipped': instance.isShipped,
      'is_paid': instance.isPaid,
      'grand_total_shipping': instance.grandTotalShipping,
      'grand_total_invoice': instance.grandTotalInvoice,
      'total_payment': instance.totalPayment,
    };
