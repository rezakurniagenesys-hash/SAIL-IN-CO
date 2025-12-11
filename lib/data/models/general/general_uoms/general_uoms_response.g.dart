// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_uoms_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UOMItem _$UOMItemFromJson(Map<String, dynamic> json) => UOMItem(
  inventoryId: json['inventory_id'] as String,
  uomId: json['uom_id'] as String,
  uomName: json['uom_name'] as String,
  value: json['value'] as String,
  isDefault: (json['default'] as num).toInt(),
  notes: json['notes'] as String,
);

Map<String, dynamic> _$UOMItemToJson(UOMItem instance) => <String, dynamic>{
  'inventory_id': instance.inventoryId,
  'uom_id': instance.uomId,
  'uom_name': instance.uomName,
  'value': instance.value,
  'default': instance.isDefault,
  'notes': instance.notes,
};
