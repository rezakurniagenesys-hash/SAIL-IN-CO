// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_return_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesReturnResponse _$SalesReturnResponseFromJson(Map<String, dynamic> json) =>
    SalesReturnResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => SalesReturnData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SalesReturnResponseToJson(
  SalesReturnResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
};

SalesReturnData _$SalesReturnDataFromJson(Map<String, dynamic> json) =>
    SalesReturnData(
      salesReturnId: json['sales_return_id'] as String,
      sisa: json['sisa'] as String,
    );

Map<String, dynamic> _$SalesReturnDataToJson(SalesReturnData instance) =>
    <String, dynamic>{
      'sales_return_id': instance.salesReturnId,
      'sisa': instance.sisa,
    };
