// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_order_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesOrderDetail _$SalesOrderDetailFromJson(Map<String, dynamic> json) =>
    SalesOrderDetail(
      index: (json['index'] as num).toInt(),
      inventoryId: json['inventory_id'] as String,
      voidValue: (json['voidvalue'] as num).toInt(),
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

Map<String, dynamic> _$SalesOrderDetailToJson(SalesOrderDetail instance) =>
    <String, dynamic>{
      'index': instance.index,
      'inventory_id': instance.inventoryId,
      'voidvalue': instance.voidValue,
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
