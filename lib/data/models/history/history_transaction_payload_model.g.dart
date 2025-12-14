// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_transaction_payload_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryTransactionPayloadModel _$HistoryTransactionPayloadModelFromJson(
  Map<String, dynamic> json,
) => HistoryTransactionPayloadModel(
  userId: json['user_id'] as String,
  type: json['type'] as String?,
  startDate: json['start_date'] as String,
  endDate: json['end_date'] as String,
  page: (json['page'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
  salesId: json['sales_id'] as String?,
  salesDate: json['sales_date'] as String?,
  inventoryName: json['inventory_name'] as String?,
  search: json['search'] as String?,
);

Map<String, dynamic> _$HistoryTransactionPayloadModelToJson(
  HistoryTransactionPayloadModel instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'type': ?instance.type,
  'start_date': instance.startDate,
  'end_date': instance.endDate,
  'page': instance.page,
  'limit': instance.limit,
  'sales_id': ?instance.salesId,
  'sales_date': ?instance.salesDate,
  'inventory_name': ?instance.inventoryName,
  'search': ?instance.search,
};
