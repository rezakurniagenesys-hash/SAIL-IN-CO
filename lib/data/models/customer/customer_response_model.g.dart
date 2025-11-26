// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerResponseModel _$CustomerResponseModelFromJson(
  Map<String, dynamic> json,
) => CustomerResponseModel(
  status: json['status'] as bool?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : CustomerData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CustomerResponseModelToJson(
  CustomerResponseModel instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
