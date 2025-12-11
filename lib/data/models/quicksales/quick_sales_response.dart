import 'package:json_annotation/json_annotation.dart';

part 'quick_sales_response.g.dart';

//
// ──────────────────────────────────────────────────────────────────────────────
//   RESPONSE
// ──────────────────────────────────────────────────────────────────────────────
//

@JsonSerializable(explicitToJson: true)
class QuickSalesResponse {
  final bool status;
  final String message;
  final QuickSalesData? data;

  QuickSalesResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory QuickSalesResponse.fromJson(Map<String, dynamic> json) =>
      _$QuickSalesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuickSalesResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class QuickSalesData {
  @JsonKey(name: 'quickSales')
  final QuickSalesModel quickSales;

  QuickSalesData({required this.quickSales});

  factory QuickSalesData.fromJson(Map<String, dynamic> json) =>
      _$QuickSalesDataFromJson(json);

  Map<String, dynamic> toJson() => _$QuickSalesDataToJson(this);
}

//
// ──────────────────────────────────────────────────────────────────────────────
//   QUICK SALES MODEL
// ──────────────────────────────────────────────────────────────────────────────
//

@JsonSerializable(explicitToJson: true)
class QuickSalesModel {
  @JsonKey(name: 'quick_sales_id')
  final String quickSalesId;

  @JsonKey(name: 'quick_sales_date')
  final String quickSalesDate;

  @JsonKey(name: 'customer_id')
  final String customerId;

  @JsonKey(name: 'area_id')
  final String areaId;

  @JsonKey(name: 'sales_id')
  final String salesId;

  @JsonKey(name: 'payment_type')
  final int paymentType;

  @JsonKey(name: 'source_id')
  final String sourceId;

  @JsonKey(name: 'warehouse_id')
  final String warehouseId;

  @JsonKey(name: 'currency_id')
  final String currencyId;

  final num rate;

  @JsonKey(name: 'sub_total')
  final num subTotal;

  final num discount;
  final num total;

  @JsonKey(name: 'grand_total')
  final num grandTotal;

  final String notes;

  @JsonKey(name: 'void')
  final int isVoid;

  final int status;

  @JsonKey(name: 'destination_address')
  final String destinationAddress;

  @JsonKey(name: 'sales_type')
  final int salesType;

  @JsonKey(name: 'user_record')
  final String userRecord;

  @JsonKey(name: 'dt_record')
  final String dtRecord;

  final QuickCustomerModel? customer;
  final QuickSalesPersonModel? sales;
  final QuickWarehouseModel? warehouse;
  final QuickAreaModel? area;
  final QuickSourceModel? source;

  final List<QuickSalesDetailModel> details;

  QuickSalesModel({
    required this.quickSalesId,
    required this.quickSalesDate,
    required this.customerId,
    required this.areaId,
    required this.salesId,
    required this.paymentType,
    required this.sourceId,
    required this.warehouseId,
    required this.currencyId,
    required this.rate,
    required this.subTotal,
    required this.discount,
    required this.total,
    required this.grandTotal,
    required this.notes,
    required this.isVoid,
    required this.status,
    required this.destinationAddress,
    required this.salesType,
    required this.userRecord,
    required this.dtRecord,
    required this.customer,
    required this.sales,
    required this.warehouse,
    required this.area,
    required this.source,
    required this.details,
  });

  factory QuickSalesModel.fromJson(Map<String, dynamic> json) =>
      _$QuickSalesModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuickSalesModelToJson(this);
}

//
// ──────────────────────────────────────────────────────────────────────────────
//   SUPPORT MODELS (Customer, Sales, Warehouse, Area, Source)
// ──────────────────────────────────────────────────────────────────────────────
//

@JsonSerializable()
class QuickCustomerModel {
  @JsonKey(name: 'no_acc6')
  final String noAcc6;

  @JsonKey(name: 'nm_acc6')
  final String name;

  QuickCustomerModel({required this.noAcc6, required this.name});

  factory QuickCustomerModel.fromJson(Map<String, dynamic> json) =>
      _$QuickCustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuickCustomerModelToJson(this);
}

@JsonSerializable()
class QuickSalesPersonModel {
  @JsonKey(name: 'no_acc6')
  final String noAcc6;

  @JsonKey(name: 'nm_acc6')
  final String name;

  QuickSalesPersonModel({required this.noAcc6, required this.name});

  factory QuickSalesPersonModel.fromJson(Map<String, dynamic> json) =>
      _$QuickSalesPersonModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuickSalesPersonModelToJson(this);
}

@JsonSerializable()
class QuickWarehouseModel {
  @JsonKey(name: 'warehouse_id')
  final String warehouseId;

  @JsonKey(name: 'warehouse_name')
  final String warehouseName;

  QuickWarehouseModel({
    required this.warehouseId,
    required this.warehouseName,
  });

  factory QuickWarehouseModel.fromJson(Map<String, dynamic> json) =>
      _$QuickWarehouseModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuickWarehouseModelToJson(this);
}

@JsonSerializable()
class QuickAreaModel {
  @JsonKey(name: 'area_id')
  final String areaId;

  @JsonKey(name: 'area_name')
  final String areaName;

  QuickAreaModel({required this.areaId, required this.areaName});

  factory QuickAreaModel.fromJson(Map<String, dynamic> json) =>
      _$QuickAreaModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuickAreaModelToJson(this);
}

@JsonSerializable()
class QuickSourceModel {
  @JsonKey(name: 'source_id')
  final String sourceId;

  @JsonKey(name: 'source_name')
  final String sourceName;

  QuickSourceModel({
    required this.sourceId,
    required this.sourceName,
  });

  factory QuickSourceModel.fromJson(Map<String, dynamic> json) =>
      _$QuickSourceModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuickSourceModelToJson(this);
}

//
// ──────────────────────────────────────────────────────────────────────────────
//   DETAILS MODEL
// ──────────────────────────────────────────────────────────────────────────────
//

@JsonSerializable(explicitToJson: true)
class QuickSalesDetailModel {
  @JsonKey(name: 'quick_sales_id')
  final String quickSalesId;

  final int index;

  @JsonKey(name: 'inventory_id')
  final String inventoryId;

  @JsonKey(name: 'void')
  final int isVoid;

  @JsonKey(name: 'uom_id')
  final String uomId;

  @JsonKey(name: 'uom_id2')
  final String uomId2;

  final num qty;
  final num qty2;
  final num price;

  @JsonKey(name: 'sub_total')
  final num subTotal;

  @JsonKey(name: 'grand_total')
  final num grandTotal;

  final String notes;

  @JsonKey(name: 'user_record')
  final String userRecord;

  @JsonKey(name: 'dt_record')
  final String dtRecord;

  final QuickInventoryModel? inventory;
  final QuickUomModel? uom;
  final QuickUomModel? uom2;

  QuickSalesDetailModel({
    required this.quickSalesId,
    required this.index,
    required this.inventoryId,
    required this.isVoid,
    required this.uomId,
    required this.uomId2,
    required this.qty,
    required this.qty2,
    required this.price,
    required this.subTotal,
    required this.grandTotal,
    required this.notes,
    required this.userRecord,
    required this.dtRecord,
    required this.inventory,
    required this.uom,
    required this.uom2,
  });

  factory QuickSalesDetailModel.fromJson(Map<String, dynamic> json) =>
      _$QuickSalesDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuickSalesDetailModelToJson(this);
}

//
// ──────────────────────────────────────────────────────────────────────────────
//   INVENTORY & UOM MODELS
// ──────────────────────────────────────────────────────────────────────────────
//

@JsonSerializable()
class QuickInventoryModel {
  @JsonKey(name: 'inventory_id')
  final String inventoryId;

  @JsonKey(name: 'inventory_name')
  final String inventoryName;

  QuickInventoryModel({
    required this.inventoryId,
    required this.inventoryName,
  });

  factory QuickInventoryModel.fromJson(Map<String, dynamic> json) =>
      _$QuickInventoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuickInventoryModelToJson(this);
}

@JsonSerializable()
class QuickUomModel {
  @JsonKey(name: 'uom_id')
  final String uomId;

  @JsonKey(name: 'uom_name')
  final String uomName;

  QuickUomModel({required this.uomId, required this.uomName});

  factory QuickUomModel.fromJson(Map<String, dynamic> json) =>
      _$QuickUomModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuickUomModelToJson(this);
}
