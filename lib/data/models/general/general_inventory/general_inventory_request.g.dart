// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_inventory_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralInventoryRequest _$GeneralInventoryRequestFromJson(
  Map<String, dynamic> json,
) => GeneralInventoryRequest(
  page: (json['page'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
  warehouseId: json['warehouseId'] as String?,
  date: json['date'] as String?,
  search: json['search'] as String?,
);

Map<String, dynamic> _$GeneralInventoryRequestToJson(
  GeneralInventoryRequest instance,
) => <String, dynamic>{
  'page': instance.page,
  'limit': instance.limit,
  'warehouseId': instance.warehouseId,
  'date': instance.date,
  'search': instance.search,
};
