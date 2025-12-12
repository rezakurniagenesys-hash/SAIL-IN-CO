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
      totalQty: (json['total_qty'] as num).toInt(),
      inventoryNames: json['inventory_names'] as String,
      isShipped: (json['is_shipped'] as num).toInt(),
      isPaid: (json['is_paid'] as num).toInt(),
      customerId: (json['customer_id'] as num).toInt(),
      shippingId: (json['shipping_id'] as num).toInt(),
    );

Map<String, dynamic> _$SalesOrderModelToJson(SalesOrderModel instance) =>
    <String, dynamic>{
      'sales_order_id': instance.salesOrderId,
      'sales_order_date': instance.salesOrderDate,
      'total_qty': instance.totalQty,
      'inventory_names': instance.inventoryNames,
      'is_shipped': instance.isShipped,
      'is_paid': instance.isPaid,
      'customer_id': instance.customerId,
      'shipping_id': instance.shippingId,
    };
