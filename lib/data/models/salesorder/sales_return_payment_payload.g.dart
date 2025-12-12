// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_return_payment_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesReturnPaymentPayload _$SalesReturnPaymentPayloadFromJson(
  Map<String, dynamic> json,
) => SalesReturnPaymentPayload(
  salesReturnDate: json['sales_return_date'] as String,
  customerId: json['customer_id'] as String,
  areaId: json['area_id'] as String,
  salesId: json['sales_id'] as String,
  paymentType: (json['payment_type'] as num).toInt(),
  sourceId: json['source_id'] as String,
  warehouseId: json['warehouse_id'] as String,
  currencyId: json['currency_id'] as String,
  rate: json['rate'] as num,
  subTotal: json['sub_total'] as num,
  discount: json['discount'] as num,
  total: json['total'] as num,
  grandTotal: json['grand_total'] as num,
  notes: json['notes'] as String,
  isVoid: (json['voidvalue'] as num).toInt(),
  status: (json['status'] as num).toInt(),
  destinationAddress: json['destination_address'] as String,
  salesType: (json['sales_type'] as num).toInt(),
  userRecord: json['user_record'] as String,
  details: (json['details'] as List<dynamic>)
      .map((e) => SalesOrderDetail.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SalesReturnPaymentPayloadToJson(
  SalesReturnPaymentPayload instance,
) => <String, dynamic>{
  'sales_return_date': instance.salesReturnDate,
  'customer_id': instance.customerId,
  'area_id': instance.areaId,
  'sales_id': instance.salesId,
  'payment_type': instance.paymentType,
  'source_id': instance.sourceId,
  'warehouse_id': instance.warehouseId,
  'currency_id': instance.currencyId,
  'rate': instance.rate,
  'sub_total': instance.subTotal,
  'discount': instance.discount,
  'total': instance.total,
  'grand_total': instance.grandTotal,
  'notes': instance.notes,
  'voidvalue': instance.isVoid,
  'status': instance.status,
  'destination_address': instance.destinationAddress,
  'sales_type': instance.salesType,
  'user_record': instance.userRecord,
  'details': instance.details.map((e) => e.toJson()).toList(),
};
