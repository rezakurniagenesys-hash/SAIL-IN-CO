// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_order_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesOrderRequestModel _$SalesOrderRequestModelFromJson(
  Map<String, dynamic> json,
) => SalesOrderRequestModel(
  userId: json['user_id'] as String,
  voidFlag: (json['void'] as num).toInt(),
  status: (json['status'] as num).toInt(),
  startDate: json['start_date'] as String,
  endDate: json['end_date'] as String,
  search: json['search'] as String? ?? '',
  page: (json['page'] as num?)?.toInt() ?? 1,
  limit: (json['limit'] as num?)?.toInt() ?? 50,
);

Map<String, dynamic> _$SalesOrderRequestModelToJson(
  SalesOrderRequestModel instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'void': instance.voidFlag,
  'status': instance.status,
  'start_date': instance.startDate,
  'end_date': instance.endDate,
  'search': instance.search,
  'page': instance.page,
  'limit': instance.limit,
};
