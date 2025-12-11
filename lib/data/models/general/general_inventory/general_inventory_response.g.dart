// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_inventory_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralInventoryResponse _$GeneralInventoryResponseFromJson(
  Map<String, dynamic> json,
) => GeneralInventoryResponse(
  status: json['status'] as bool,
  message: json['message'] as String,
  data: InventoryDataWrapper.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GeneralInventoryResponseToJson(
  GeneralInventoryResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

InventoryDataWrapper _$InventoryDataWrapperFromJson(
  Map<String, dynamic> json,
) => InventoryDataWrapper(
  inventoryData: (json['inventoryData'] as List<dynamic>)
      .map((e) => InventoryItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
  filters: Filters.fromJson(json['filters'] as Map<String, dynamic>),
);

Map<String, dynamic> _$InventoryDataWrapperToJson(
  InventoryDataWrapper instance,
) => <String, dynamic>{
  'inventoryData': instance.inventoryData,
  'pagination': instance.pagination,
  'filters': instance.filters,
};

InventoryItem _$InventoryItemFromJson(Map<String, dynamic> json) =>
    InventoryItem(
      inventoryId: json['inventory_id'] as String,
      inventoryName: json['inventory_name'] as String,
      typeId: json['type_id'] as String,
      typeName: json['type_name'] as String,
      uomId: json['uom_id'] as String,
      uomName: json['uom_name'] as String,
      categoryId: json['category_id'] as String,
      categoryName: json['category_name'] as String,
      varietyId: json['variety_id'] as String?,
      varietyName: json['variety_name'] as String?,
      brandId: json['brand_id'] as String?,
      brandName: json['brand_name'] as String?,
      internalName: json['internal_name'] as String?,
      ratePrice: json['rate_price'] as String?,
      price: json['price'] as String?,
      currentStock: json['current_stock'],
      stockWarehouseId: json['stock_warehouse_id'] as String?,
      stockWarehouseName: json['stock_warehouse_name'] as String?,
      stockUomName: json['stock_uom_name'] as String?,
      uoms: (json['uoms'] as List<dynamic>?)
          ?.map((e) => UOMItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InventoryItemToJson(InventoryItem instance) =>
    <String, dynamic>{
      'inventory_id': instance.inventoryId,
      'inventory_name': instance.inventoryName,
      'type_id': instance.typeId,
      'type_name': instance.typeName,
      'uom_id': instance.uomId,
      'uom_name': instance.uomName,
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'variety_id': instance.varietyId,
      'variety_name': instance.varietyName,
      'brand_id': instance.brandId,
      'brand_name': instance.brandName,
      'internal_name': instance.internalName,
      'rate_price': instance.ratePrice,
      'price': instance.price,
      'current_stock': instance.currentStock,
      'stock_warehouse_id': instance.stockWarehouseId,
      'stock_warehouse_name': instance.stockWarehouseName,
      'stock_uom_name': instance.stockUomName,
      'uoms': instance.uoms,
    };
