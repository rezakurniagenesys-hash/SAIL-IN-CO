import 'package:json_annotation/json_annotation.dart';

part 'stock_response.g.dart';

@JsonSerializable()
class StockResponse {
  final bool? status;
  final String? message;
  final StockData? data;

  StockResponse({
    this.status,
    this.message,
    this.data,
  });

  factory StockResponse.fromJson(Map<String, dynamic> json) =>
      _$StockResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StockResponseToJson(this);
}

@JsonSerializable()
class StockData {
  final List<StockItem>? stock;

  StockData({this.stock});

  factory StockData.fromJson(Map<String, dynamic> json) =>
      _$StockDataFromJson(json);

  Map<String, dynamic> toJson() => _$StockDataToJson(this);
}

@JsonSerializable()
class StockItem {
  @JsonKey(name: "inventory_id")
  final String? inventoryId;

  @JsonKey(name: "inventory_name")
  final String? inventoryName;

  @JsonKey(name: "warehouse_id")
  final String? warehouseId;

  @JsonKey(name: "warehouse_name")
  final String? warehouseName;

  @JsonKey(name: "total_stock")
  final int? totalStock;

  @JsonKey(name: "uom_name")
  final String? uomName;

  StockItem({
    this.inventoryId,
    this.inventoryName,
    this.warehouseId,
    this.warehouseName,
    this.totalStock,
    this.uomName,
  });

  factory StockItem.fromJson(Map<String, dynamic> json) =>
      _$StockItemFromJson(json);

  Map<String, dynamic> toJson() => _$StockItemToJson(this);
}
