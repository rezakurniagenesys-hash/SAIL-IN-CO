// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_order_detail_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesOrderDetailResponseModel _$SalesOrderDetailResponseModelFromJson(
  Map<String, dynamic> json,
) => SalesOrderDetailResponseModel(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: SalesOrderHeaderModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SalesOrderDetailResponseModelToJson(
  SalesOrderDetailResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data.toJson(),
};

SalesOrderHeaderModel _$SalesOrderHeaderModelFromJson(
  Map<String, dynamic> json,
) => SalesOrderHeaderModel(
  salesOrderId: json['sales_order_id'] as String,
  salesOrderDate: json['sales_order_date'] as String,
  customerId: json['customer_id'] as String,
  salesId: json['sales_id'] as String,
  customerAddress: json['customer_address'],
  notes: json['notes'],
  warehouseId: json['warehouse_id'] as String,
  areaId: json['area_id'] as String,
  sourceId: json['source_id'] as String,
  currencyId: json['currency_id'] as String,
  rate: json['rate'] as String,
  subTotal: json['sub_total'] as String,
  total: json['total'] as String,
  vatValue: json['vat_value'] as String?,
  grandTotal: json['grand_total'] as String,
  dpValue: json['dp_value'] as String?,
  userRecord: json['user_record'] as String,
  status: (json['status'] as num).toInt(),
  voidValue: (json['voidValue'] as num).toInt(),
  dtRecord: json['dt_record'] as String,
  customerNoAcc6: json['customer_no_acc6'] as String,
  customerNmAcc6: json['customer_nm_acc6'] as String,
  salesNoAcc6: json['sales_no_acc6'] as String,
  salesNmAcc6: json['sales_nm_acc6'] as String,
  warehouseWarehouseId: json['warehouse_warehouse_id'] as String,
  warehouseWarehouseName: json['warehouse_warehouse_name'] as String,
  areaAreaId: json['area_area_id'] as String,
  areaAreaName: json['area_area_name'] as String,
  sourceSourceId: json['source_source_id'] as String,
  sourceSourceName: json['source_source_name'] as String,
  shippingId: json['shipping_id'],
  companyName: json['company_name'],
  customerGroupName: json['customer_group_name'],
  companyAddress: json['company_address'],
  companyLogo: json['company_logo'],
  customer: json['customer'] == null
      ? null
      : CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
  sales: json['sales'] == null
      ? null
      : SalesModel.fromJson(json['sales'] as Map<String, dynamic>),
  warehouse: json['warehouse'] == null
      ? null
      : WarehouseModel.fromJson(json['warehouse'] as Map<String, dynamic>),
  area: json['area'] == null
      ? null
      : AreaModel.fromJson(json['area'] as Map<String, dynamic>),
  source: json['source'] == null
      ? null
      : SourceModel.fromJson(json['source'] as Map<String, dynamic>),
  details: (json['details'] as List<dynamic>)
      .map((e) => SalesOrderDetailModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SalesOrderHeaderModelToJson(
  SalesOrderHeaderModel instance,
) => <String, dynamic>{
  'sales_order_id': instance.salesOrderId,
  'sales_order_date': instance.salesOrderDate,
  'customer_id': instance.customerId,
  'sales_id': instance.salesId,
  'warehouse_id': instance.warehouseId,
  'area_id': instance.areaId,
  'source_id': instance.sourceId,
  'currency_id': instance.currencyId,
  'rate': instance.rate,
  'sub_total': instance.subTotal,
  'total': instance.total,
  'vat_value': instance.vatValue,
  'grand_total': instance.grandTotal,
  'dp_value': instance.dpValue,
  'user_record': instance.userRecord,
  'status': instance.status,
  'notes': instance.notes,
  'voidValue': instance.voidValue,
  'dt_record': instance.dtRecord,
  'customer_no_acc6': instance.customerNoAcc6,
  'customer_nm_acc6': instance.customerNmAcc6,
  'customer_address': instance.customerAddress,
  'sales_no_acc6': instance.salesNoAcc6,
  'sales_nm_acc6': instance.salesNmAcc6,
  'warehouse_warehouse_id': instance.warehouseWarehouseId,
  'warehouse_warehouse_name': instance.warehouseWarehouseName,
  'area_area_id': instance.areaAreaId,
  'area_area_name': instance.areaAreaName,
  'source_source_id': instance.sourceSourceId,
  'source_source_name': instance.sourceSourceName,
  'shipping_id': instance.shippingId,
  'customer_group_name': instance.customerGroupName,
  'company_name': instance.companyName,
  'company_address': instance.companyAddress,
  'company_logo': instance.companyLogo,
  'customer': instance.customer?.toJson(),
  'sales': instance.sales?.toJson(),
  'warehouse': instance.warehouse?.toJson(),
  'area': instance.area?.toJson(),
  'source': instance.source?.toJson(),
  'details': instance.details.map((e) => e.toJson()).toList(),
};

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel(
      noAcc6: json['no_acc6'] as String,
      nmAcc6: json['nm_acc6'] as String,
    );

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{'no_acc6': instance.noAcc6, 'nm_acc6': instance.nmAcc6};

SalesModel _$SalesModelFromJson(Map<String, dynamic> json) => SalesModel(
  noAcc6: json['no_acc6'] as String,
  nmAcc6: json['nm_acc6'] as String,
);

Map<String, dynamic> _$SalesModelToJson(SalesModel instance) =>
    <String, dynamic>{'no_acc6': instance.noAcc6, 'nm_acc6': instance.nmAcc6};

WarehouseModel _$WarehouseModelFromJson(Map<String, dynamic> json) =>
    WarehouseModel(
      warehouseId: json['warehouse_id'] as String,
      warehouseName: json['warehouse_name'] as String,
    );

Map<String, dynamic> _$WarehouseModelToJson(WarehouseModel instance) =>
    <String, dynamic>{
      'warehouse_id': instance.warehouseId,
      'warehouse_name': instance.warehouseName,
    };

AreaModel _$AreaModelFromJson(Map<String, dynamic> json) => AreaModel(
  areaId: json['area_id'] as String,
  areaName: json['area_name'] as String,
);

Map<String, dynamic> _$AreaModelToJson(AreaModel instance) => <String, dynamic>{
  'area_id': instance.areaId,
  'area_name': instance.areaName,
};

SourceModel _$SourceModelFromJson(Map<String, dynamic> json) => SourceModel(
  sourceId: json['source_id'] as String,
  sourceName: json['source_name'] as String,
);

Map<String, dynamic> _$SourceModelToJson(SourceModel instance) =>
    <String, dynamic>{
      'source_id': instance.sourceId,
      'source_name': instance.sourceName,
    };

SalesOrderDetailModel _$SalesOrderDetailModelFromJson(
  Map<String, dynamic> json,
) => SalesOrderDetailModel(
  salesOrderId: json['sales_order_id'] as String,
  index: (json['index'] as num).toInt(),
  descriptionIndex: json['description_index'],
  inventoryId: json['inventory_id'] as String,
  quotationId: json['quotation_id'],
  barcode: json['barcode'],
  voidFlag: json['void'],
  voidNotes: json['void_notes'],
  uomId: json['uom_id'] as String,
  uomId2: json['uom_id2'] as String,
  qty: json['qty'] as String,
  qty2: json['qty2'] as String,
  disc: json['disc'],
  price: json['price'] as String,
  price2: json['price2'],
  discValue: json['disc_value'],
  disc2Value: json['disc2_value'],
  subTotal: json['sub_total'] as String,
  vatValue: json['vat_value'],
  taxId: json['tax_id'],
  taxPercentage: json['tax_percentage'],
  taxValue: json['tax_value'],
  grandTotal: json['grand_total'] as String,
  notes: json['notes'] as String,
  dtRecord: json['dt_record'],
  userRecord: json['user_record'] as String,
  dtModified: json['dt_modified'],
  userModified: json['user_modified'],
  discPercentageValue: json['DiscPercentage_value'],
  inventoryName: json['inventory_name'] as String,
  uomName: json['uom_name'] as String,
  uomName2: json['uom_name2'] as String,
  inventory: json['inventory'] == null
      ? null
      : InventoryRefModel.fromJson(json['inventory'] as Map<String, dynamic>),
  uom: json['uom'] == null
      ? null
      : UomRefModel.fromJson(json['uom'] as Map<String, dynamic>),
  uom2: json['uom2'] == null
      ? null
      : UomRefModel.fromJson(json['uom2'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SalesOrderDetailModelToJson(
  SalesOrderDetailModel instance,
) => <String, dynamic>{
  'sales_order_id': instance.salesOrderId,
  'index': instance.index,
  'description_index': instance.descriptionIndex,
  'inventory_id': instance.inventoryId,
  'quotation_id': instance.quotationId,
  'barcode': instance.barcode,
  'void': instance.voidFlag,
  'void_notes': instance.voidNotes,
  'uom_id': instance.uomId,
  'uom_id2': instance.uomId2,
  'qty': instance.qty,
  'qty2': instance.qty2,
  'disc': instance.disc,
  'price': instance.price,
  'price2': instance.price2,
  'disc_value': instance.discValue,
  'disc2_value': instance.disc2Value,
  'sub_total': instance.subTotal,
  'vat_value': instance.vatValue,
  'tax_id': instance.taxId,
  'tax_percentage': instance.taxPercentage,
  'tax_value': instance.taxValue,
  'grand_total': instance.grandTotal,
  'notes': instance.notes,
  'dt_record': instance.dtRecord,
  'user_record': instance.userRecord,
  'dt_modified': instance.dtModified,
  'user_modified': instance.userModified,
  'DiscPercentage_value': instance.discPercentageValue,
  'inventory_name': instance.inventoryName,
  'uom_name': instance.uomName,
  'uom_name2': instance.uomName2,
  'inventory': instance.inventory?.toJson(),
  'uom': instance.uom?.toJson(),
  'uom2': instance.uom2?.toJson(),
};

InventoryRefModel _$InventoryRefModelFromJson(Map<String, dynamic> json) =>
    InventoryRefModel(
      inventoryId: json['inventory_id'] as String,
      inventoryName: json['inventory_name'] as String,
    );

Map<String, dynamic> _$InventoryRefModelToJson(InventoryRefModel instance) =>
    <String, dynamic>{
      'inventory_id': instance.inventoryId,
      'inventory_name': instance.inventoryName,
    };

UomRefModel _$UomRefModelFromJson(Map<String, dynamic> json) => UomRefModel(
  uomId: json['uom_id'] as String,
  uomName: json['uom_name'] as String,
);

Map<String, dynamic> _$UomRefModelToJson(UomRefModel instance) =>
    <String, dynamic>{'uom_id': instance.uomId, 'uom_name': instance.uomName};
