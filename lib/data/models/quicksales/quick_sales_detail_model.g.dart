// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_sales_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuickSalesDetailModel _$QuickSalesDetailModelFromJson(
  Map<String, dynamic> json,
) => QuickSalesDetailModel(
  index: (json['index'] as num).toInt(),
  inventoryId: json['inventory_id'] as String,
  isVoid: (json['voidvalue'] as num).toInt(),
  uomId: json['uom_id'] as String,
  uomId2: json['uom_id2'] as String,
  qty: json['qty'] as num,
  qty2: json['qty2'] as num,
  price: json['price'] as num,
  subTotal: json['sub_total'] as num,
  grandTotal: json['grand_total'] as num,
  notes: json['notes'] as String,
  userRecord: json['user_record'] as String,
);

Map<String, dynamic> _$QuickSalesDetailModelToJson(
  QuickSalesDetailModel instance,
) => <String, dynamic>{
  'index': instance.index,
  'inventory_id': instance.inventoryId,
  'voidvalue': instance.isVoid,
  'uom_id': instance.uomId,
  'uom_id2': instance.uomId2,
  'qty': instance.qty,
  'qty2': instance.qty2,
  'price': instance.price,
  'sub_total': instance.subTotal,
  'grand_total': instance.grandTotal,
  'notes': instance.notes,
  'user_record': instance.userRecord,
};
