// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outstanding_payment_payload_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutstandingPaymentPayloadModel _$OutstandingPaymentPayloadModelFromJson(
  Map<String, dynamic> json,
) => OutstandingPaymentPayloadModel(
  invoiceId: json['invoice_id'] as String,
  slipId: json['slip_id'] as String,
  salesReturnId: json['sales_return_id'] as String,
  salesReturnPayment: json['sales_return_payment'] as num,
  remainingPayment: json['remaining_payment'] as num,
  userRecord: json['user_record'] as String,
);

Map<String, dynamic> _$OutstandingPaymentPayloadModelToJson(
  OutstandingPaymentPayloadModel instance,
) => <String, dynamic>{
  'invoice_id': instance.invoiceId,
  'slip_id': instance.slipId,
  'sales_return_id': instance.salesReturnId,
  'sales_return_payment': instance.salesReturnPayment,
  'remaining_payment': instance.remainingPayment,
  'user_record': instance.userRecord,
};
