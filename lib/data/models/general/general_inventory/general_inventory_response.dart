import 'package:json_annotation/json_annotation.dart';
import 'package:sail_in_co/data/models/filters/filters.dart';
import 'package:sail_in_co/data/models/general/general_uoms/general_uoms_response.dart';
import 'package:sail_in_co/data/models/pagination/pagination.dart';

part 'general_inventory_response.g.dart';

@JsonSerializable()
class GeneralInventoryResponse {
  final bool status;
  final String message;
  final InventoryDataWrapper data;

  GeneralInventoryResponse({required this.status, required this.message, required this.data});

  factory GeneralInventoryResponse.fromJson(Map<String, dynamic> json) => _$GeneralInventoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralInventoryResponseToJson(this);
}

@JsonSerializable()
class InventoryDataWrapper {
  @JsonKey(name: 'inventoryData')
  final List<InventoryItem> inventoryData;

  final Pagination pagination;
  final Filters filters;

  InventoryDataWrapper({required this.inventoryData, required this.pagination, required this.filters});

  factory InventoryDataWrapper.fromJson(Map<String, dynamic> json) => _$InventoryDataWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryDataWrapperToJson(this);
}

@JsonSerializable()
class InventoryItem {
  @JsonKey(name: 'inventory_id')
  final String inventoryId;

  @JsonKey(name: 'inventory_name')
  final String inventoryName;

  @JsonKey(name: 'type_id')
  final String typeId;

  @JsonKey(name: 'type_name')
  final String typeName;

  @JsonKey(name: 'uom_id')
  final String uomId;

  @JsonKey(name: 'uom_name')
  final String uomName;

  @JsonKey(name: 'category_id')
  final String categoryId;

  @JsonKey(name: 'category_name')
  final String categoryName;

  @JsonKey(name: 'variety_id')
  final String? varietyId;

  @JsonKey(name: 'variety_name')
  final String? varietyName;

  @JsonKey(name: 'brand_id')
  final String? brandId;

  @JsonKey(name: 'brand_name')
  final String? brandName;

  @JsonKey(name: 'internal_name')
  final String? internalName;

  @JsonKey(name: 'rate_price')
  final String? ratePrice;

  @JsonKey(name: 'price')
  final String? price;

  @JsonKey(name: 'current_stock')
  final dynamic currentStock;

  @JsonKey(name: 'stock_warehouse_id')
  final String? stockWarehouseId;

  @JsonKey(name: 'stock_warehouse_name')
  final String? stockWarehouseName;

  @JsonKey(name: 'stock_uom_name')
  final String? stockUomName;

  final List<UOMItem>? uoms;

  InventoryItem({
    required this.inventoryId,
    required this.inventoryName,
    required this.typeId,
    required this.typeName,
    required this.uomId,
    required this.uomName,
    required this.categoryId,
    required this.categoryName,
    this.varietyId,
    this.varietyName,
    this.brandId,
    this.brandName,
    this.internalName,
    this.ratePrice,
    this.price,
    required this.currentStock,
    this.stockWarehouseId,
    this.stockWarehouseName,
    this.stockUomName,
    this.uoms,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) => _$InventoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryItemToJson(this);
}
