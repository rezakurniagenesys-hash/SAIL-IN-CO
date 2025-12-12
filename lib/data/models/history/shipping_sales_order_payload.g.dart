// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping_sales_order_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShippingSalesOrderPayload _$ShippingSalesOrderPayloadFromJson(
  Map<String, dynamic> json,
) => ShippingSalesOrderPayload(
  salesOrderId: json['sales_order_id'] as String,
  userRecord: json['user_record'] as String,
);

Map<String, dynamic> _$ShippingSalesOrderPayloadToJson(
  ShippingSalesOrderPayload instance,
) => <String, dynamic>{
  'sales_order_id': instance.salesOrderId,
  'user_record': instance.userRecord,
};
