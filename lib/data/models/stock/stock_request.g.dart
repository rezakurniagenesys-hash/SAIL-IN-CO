// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockRequest _$StockRequestFromJson(Map<String, dynamic> json) => StockRequest(
  warehouseId: json['warehouse_id'] as String,
  date: json['date'] as String?,
  search: json['search'] as String?,
);

Map<String, dynamic> _$StockRequestToJson(StockRequest instance) =>
    <String, dynamic>{
      'warehouse_id': instance.warehouseId,
      'date': instance.date,
      'search': instance.search,
    };
