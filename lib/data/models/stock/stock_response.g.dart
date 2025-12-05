// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockResponse _$StockResponseFromJson(Map<String, dynamic> json) =>
    StockResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : StockData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StockResponseToJson(StockResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

StockData _$StockDataFromJson(Map<String, dynamic> json) => StockData(
  stock: (json['stock'] as List<dynamic>?)
      ?.map((e) => StockItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$StockDataToJson(StockData instance) => <String, dynamic>{
  'stock': instance.stock,
};

StockItem _$StockItemFromJson(Map<String, dynamic> json) => StockItem(
  inventoryId: json['inventory_id'] as String?,
  inventoryName: json['inventory_name'] as String?,
  warehouseId: json['warehouse_id'] as String?,
  warehouseName: json['warehouse_name'] as String?,
  totalStock: (json['total_stock'] as num?)?.toInt(),
  uomName: json['uom_name'] as String?,
);

Map<String, dynamic> _$StockItemToJson(StockItem instance) => <String, dynamic>{
  'inventory_id': instance.inventoryId,
  'inventory_name': instance.inventoryName,
  'warehouse_id': instance.warehouseId,
  'warehouse_name': instance.warehouseName,
  'total_stock': instance.totalStock,
  'uom_name': instance.uomName,
};
