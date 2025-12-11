// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodResponse _$PaymentMethodResponseFromJson(
  Map<String, dynamic> json,
) => PaymentMethodResponse(
  status: json['status'] as bool,
  message: json['message'] as String,
  data: (json['data'] as List<dynamic>)
      .map((e) => PaymentMethodData.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PaymentMethodResponseToJson(
  PaymentMethodResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
};

PaymentMethodData _$PaymentMethodDataFromJson(Map<String, dynamic> json) =>
    PaymentMethodData(
      slipId: json['slip_id'] as String,
      slipName: json['slip_name'] as String,
      slipType: json['slip_type'] as String,
      currencyId: json['currency_id'] as String,
      salesAccCode: json['sales_acc_code'] as String,
    );

Map<String, dynamic> _$PaymentMethodDataToJson(PaymentMethodData instance) =>
    <String, dynamic>{
      'slip_id': instance.slipId,
      'slip_name': instance.slipName,
      'slip_type': instance.slipType,
      'currency_id': instance.currencyId,
      'sales_acc_code': instance.salesAccCode,
    };
