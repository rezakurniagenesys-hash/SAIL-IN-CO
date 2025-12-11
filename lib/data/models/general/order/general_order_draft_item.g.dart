// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_order_draft_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralOrderDraftItem _$GeneralOrderDraftItemFromJson(
  Map<String, dynamic> json,
) => GeneralOrderDraftItem(
  inventory: InventoryItem.fromJson(json['inventory'] as Map<String, dynamic>),
  uom: UOMItem.fromJson(json['uom'] as Map<String, dynamic>),
  qty: (json['qty'] as num).toInt(),
  defaultUomName: json['defaultUomName'] as String,
  discount: (json['discount'] as num).toInt(),
  notes: json['notes'] as String,
  user_record: json['user_record'] as String,
  voidValue: (json['voidValue'] as num).toInt(),
  uom_id: json['uom_id'] as String,
  uom_id2: json['uom_id2'] as String,
  qty2: (json['qty2'] as num).toInt(),
  price: (json['price'] as num).toInt(),
  sub_total: (json['sub_total'] as num).toInt(),
  grand_total: (json['grand_total'] as num).toInt(),
  index: (json['index'] as num).toInt(),
);

Map<String, dynamic> _$GeneralOrderDraftItemToJson(
  GeneralOrderDraftItem instance,
) => <String, dynamic>{
  'inventory': instance.inventory.toJson(),
  'uom': instance.uom.toJson(),
  'voidValue': instance.voidValue,
  'uom_id': instance.uom_id,
  'uom_id2': instance.uom_id2,
  'qty': instance.qty,
  'qty2': instance.qty2,
  'defaultUomName': instance.defaultUomName,
  'discount': instance.discount,
  'notes': instance.notes,
  'user_record': instance.user_record,
  'price': instance.price,
  'sub_total': instance.sub_total,
  'grand_total': instance.grand_total,
  'index': instance.index,
};
