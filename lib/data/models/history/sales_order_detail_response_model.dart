import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'sales_order_detail_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SalesOrderDetailResponseModel {
  final bool success;
  final String message;
  final SalesOrderHeaderModel data;

  SalesOrderDetailResponseModel({required this.success, required this.message, required this.data});

  factory SalesOrderDetailResponseModel.fromJson(Map<String, dynamic> json) => _$SalesOrderDetailResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalesOrderDetailResponseModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SalesOrderHeaderModel {
  @JsonKey(name: 'sales_order_id')
  final String salesOrderId;

  @JsonKey(name: 'sales_order_date')
  final String salesOrderDate;

  @JsonKey(name: 'customer_id')
  final String customerId;

  @JsonKey(name: 'sales_id')
  final String salesId;

  @JsonKey(name: 'warehouse_id')
  final String warehouseId;

  @JsonKey(name: 'area_id')
  final String areaId;

  @JsonKey(name: 'source_id')
  final String sourceId;

  @JsonKey(name: 'currency_id')
  final String currencyId;

  final String rate;
  @JsonKey(name: 'sub_total')
  final String subTotal;
  final String total;

  @JsonKey(name: 'vat_value')
  final String? vatValue;

  @JsonKey(name: 'grand_total')
  final String grandTotal;

  @JsonKey(name: 'dp_value')
  final String? dpValue;

  @JsonKey(name: 'user_record')
  final String userRecord;

  final int status;
  final dynamic notes;

  @JsonKey(name: 'voidValue')
  final int voidValue;

  @JsonKey(name: 'dt_record')
  final String dtRecord;

  @JsonKey(name: 'customer_no_acc6')
  final String customerNoAcc6;

  @JsonKey(name: 'customer_nm_acc6')
  final String customerNmAcc6;

  @JsonKey(name: 'customer_address')
  final dynamic customerAddress;

  @JsonKey(name: 'sales_no_acc6')
  final String salesNoAcc6;

  @JsonKey(name: 'sales_nm_acc6')
  final String salesNmAcc6;

  @JsonKey(name: 'warehouse_warehouse_id')
  final String warehouseWarehouseId;

  @JsonKey(name: 'warehouse_warehouse_name')
  final String warehouseWarehouseName;

  @JsonKey(name: 'area_area_id')
  final String areaAreaId;

  @JsonKey(name: 'area_area_name')
  final String areaAreaName;

  @JsonKey(name: 'source_source_id')
  final String sourceSourceId;

  @JsonKey(name: 'source_source_name')
  final String sourceSourceName;

  @JsonKey(name: 'shipping_id')
  final dynamic shippingId;

  // company_name
  @JsonKey(name: 'company_name')
  final dynamic companyName;

  @JsonKey(name: 'company_address')
  final dynamic companyAddress;

  @JsonKey(name: 'company_logo')
  final dynamic companyLogo;

  final CustomerModel? customer;
  final SalesModel? sales;
  final WarehouseModel? warehouse;
  final AreaModel? area;
  final SourceModel? source;

  final List<SalesOrderDetailModel> details;

  SalesOrderHeaderModel({
    required this.salesOrderId,
    required this.salesOrderDate,
    required this.customerId,
    required this.salesId,
    required this.customerAddress,
    required this.notes,
    required this.warehouseId,
    required this.areaId,
    required this.sourceId,
    required this.currencyId,
    required this.rate,
    required this.subTotal,
    required this.total,
    this.vatValue,
    required this.grandTotal,
    this.dpValue,
    required this.userRecord,
    required this.status,
    required this.voidValue,
    required this.dtRecord,
    required this.customerNoAcc6,
    required this.customerNmAcc6,
    required this.salesNoAcc6,
    required this.salesNmAcc6,
    required this.warehouseWarehouseId,
    required this.warehouseWarehouseName,
    required this.areaAreaId,
    required this.areaAreaName,
    required this.sourceSourceId,
    required this.sourceSourceName,
    this.shippingId,
    this.companyName,
    this.companyAddress,
    this.companyLogo,
    this.customer,
    this.sales,
    this.warehouse,
    this.area,
    this.source,
    required this.details,
  });

  factory SalesOrderHeaderModel.fromJson(Map<String, dynamic> json) => _$SalesOrderHeaderModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalesOrderHeaderModelToJson(this);
}

// ---------------- Nested Models -------------------
@JsonSerializable()
class CustomerModel {
  @JsonKey(name: 'no_acc6')
  final String noAcc6;

  @JsonKey(name: 'nm_acc6')
  final String nmAcc6;

  CustomerModel({required this.noAcc6, required this.nmAcc6});

  factory CustomerModel.fromJson(Map<String, dynamic> json) => _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}

@JsonSerializable()
class SalesModel {
  @JsonKey(name: 'no_acc6')
  final String noAcc6;

  @JsonKey(name: 'nm_acc6')
  final String nmAcc6;

  SalesModel({required this.noAcc6, required this.nmAcc6});

  factory SalesModel.fromJson(Map<String, dynamic> json) => _$SalesModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalesModelToJson(this);
}

@JsonSerializable()
class WarehouseModel {
  @JsonKey(name: 'warehouse_id')
  final String warehouseId;

  @JsonKey(name: 'warehouse_name')
  final String warehouseName;

  WarehouseModel({required this.warehouseId, required this.warehouseName});

  factory WarehouseModel.fromJson(Map<String, dynamic> json) => _$WarehouseModelFromJson(json);

  Map<String, dynamic> toJson() => _$WarehouseModelToJson(this);
}

@JsonSerializable()
class AreaModel {
  @JsonKey(name: 'area_id')
  final String areaId;

  @JsonKey(name: 'area_name')
  final String areaName;

  AreaModel({required this.areaId, required this.areaName});

  factory AreaModel.fromJson(Map<String, dynamic> json) => _$AreaModelFromJson(json);

  Map<String, dynamic> toJson() => _$AreaModelToJson(this);
}

@JsonSerializable()
class SourceModel {
  @JsonKey(name: 'source_id')
  final String sourceId;

  @JsonKey(name: 'source_name')
  final String sourceName;

  SourceModel({required this.sourceId, required this.sourceName});

  factory SourceModel.fromJson(Map<String, dynamic> json) => _$SourceModelFromJson(json);

  Map<String, dynamic> toJson() => _$SourceModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SalesOrderDetailModel {
  @JsonKey(name: 'sales_order_id')
  final String salesOrderId;

  final int index;

  @JsonKey(name: 'description_index')
  final dynamic descriptionIndex;

  @JsonKey(name: 'inventory_id')
  final String inventoryId;

  @JsonKey(name: 'quotation_id')
  final dynamic quotationId;

  final dynamic barcode;

  @JsonKey(name: 'void')
  final dynamic voidFlag;

  @JsonKey(name: 'void_notes')
  final dynamic voidNotes;

  @JsonKey(name: 'uom_id')
  final String uomId;

  @JsonKey(name: 'uom_id2')
  final String uomId2;

  final String qty;
  final String qty2;

  final dynamic disc;
  final String price;

  @JsonKey(name: 'price2')
  final dynamic price2;

  @JsonKey(name: 'disc_value')
  final dynamic discValue;

  @JsonKey(name: 'disc2_value')
  final dynamic disc2Value;

  @JsonKey(name: 'sub_total')
  final String subTotal;

  @JsonKey(name: 'vat_value')
  final dynamic vatValue;

  @JsonKey(name: 'tax_id')
  final dynamic taxId;

  @JsonKey(name: 'tax_percentage')
  final dynamic taxPercentage;

  @JsonKey(name: 'tax_value')
  final dynamic taxValue;

  @JsonKey(name: 'grand_total')
  final String grandTotal;

  final String notes;

  @JsonKey(name: 'dt_record')
  final dynamic dtRecord;

  @JsonKey(name: 'user_record')
  final String userRecord;

  @JsonKey(name: 'dt_modified')
  final dynamic dtModified;

  @JsonKey(name: 'user_modified')
  final dynamic userModified;

  @JsonKey(name: 'DiscPercentage_value')
  final dynamic discPercentageValue;

  @JsonKey(name: 'inventory_name')
  final String inventoryName;

  @JsonKey(name: 'uom_name')
  final String uomName;

  @JsonKey(name: 'uom_name2')
  final String uomName2;

  final InventoryRefModel? inventory;
  final UomRefModel? uom;
  final UomRefModel? uom2;

  SalesOrderDetailModel({
    required this.salesOrderId,
    required this.index,
    this.descriptionIndex,
    required this.inventoryId,
    this.quotationId,
    this.barcode,
    this.voidFlag,
    this.voidNotes,
    required this.uomId,
    required this.uomId2,
    required this.qty,
    required this.qty2,
    this.disc,
    required this.price,
    this.price2,
    this.discValue,
    this.disc2Value,
    required this.subTotal,
    this.vatValue,
    this.taxId,
    this.taxPercentage,
    this.taxValue,
    required this.grandTotal,
    required this.notes,
    this.dtRecord,
    required this.userRecord,
    this.dtModified,
    this.userModified,
    this.discPercentageValue,
    required this.inventoryName,
    required this.uomName,
    required this.uomName2,
    this.inventory,
    this.uom,
    this.uom2,
  });

  factory SalesOrderDetailModel.fromJson(Map<String, dynamic> json) => _$SalesOrderDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalesOrderDetailModelToJson(this);
}

@JsonSerializable()
class InventoryRefModel {
  @JsonKey(name: 'inventory_id')
  final String inventoryId;

  @JsonKey(name: 'inventory_name')
  final String inventoryName;

  InventoryRefModel({required this.inventoryId, required this.inventoryName});

  factory InventoryRefModel.fromJson(Map<String, dynamic> json) => _$InventoryRefModelFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryRefModelToJson(this);
}

@JsonSerializable()
class UomRefModel {
  @JsonKey(name: 'uom_id')
  final String uomId;

  @JsonKey(name: 'uom_name')
  final String uomName;

  UomRefModel({required this.uomId, required this.uomName});

  factory UomRefModel.fromJson(Map<String, dynamic> json) => _$UomRefModelFromJson(json);

  Map<String, dynamic> toJson() => _$UomRefModelToJson(this);
}
