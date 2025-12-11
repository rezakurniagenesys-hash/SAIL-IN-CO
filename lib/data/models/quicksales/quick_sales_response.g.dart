// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_sales_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuickSalesResponse _$QuickSalesResponseFromJson(Map<String, dynamic> json) =>
    QuickSalesResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : QuickSalesData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuickSalesResponseToJson(QuickSalesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.toJson(),
    };

QuickSalesData _$QuickSalesDataFromJson(Map<String, dynamic> json) =>
    QuickSalesData(
      quickSales: QuickSalesModel.fromJson(
        json['quickSales'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$QuickSalesDataToJson(QuickSalesData instance) =>
    <String, dynamic>{'quickSales': instance.quickSales.toJson()};

QuickSalesModel _$QuickSalesModelFromJson(
  Map<String, dynamic> json,
) => QuickSalesModel(
  quickSalesId: json['quick_sales_id'] as String,
  quickSalesDate: json['quick_sales_date'] as String,
  customerId: json['customer_id'] as String,
  areaId: json['area_id'] as String,
  salesId: json['sales_id'] as String,
  paymentType: (json['payment_type'] as num).toInt(),
  sourceId: json['source_id'] as String,
  warehouseId: json['warehouse_id'] as String,
  currencyId: json['currency_id'] as String,
  rate: json['rate'] as num,
  subTotal: json['sub_total'] as num,
  discount: json['discount'] as num,
  total: json['total'] as num,
  grandTotal: json['grand_total'] as num,
  notes: json['notes'] as String,
  isVoid: (json['void'] as num).toInt(),
  status: (json['status'] as num).toInt(),
  destinationAddress: json['destination_address'] as String,
  salesType: (json['sales_type'] as num).toInt(),
  userRecord: json['user_record'] as String,
  dtRecord: json['dt_record'] as String,
  customer: json['customer'] == null
      ? null
      : QuickCustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
  sales: json['sales'] == null
      ? null
      : QuickSalesPersonModel.fromJson(json['sales'] as Map<String, dynamic>),
  warehouse: json['warehouse'] == null
      ? null
      : QuickWarehouseModel.fromJson(json['warehouse'] as Map<String, dynamic>),
  area: json['area'] == null
      ? null
      : QuickAreaModel.fromJson(json['area'] as Map<String, dynamic>),
  source: json['source'] == null
      ? null
      : QuickSourceModel.fromJson(json['source'] as Map<String, dynamic>),
  details: (json['details'] as List<dynamic>)
      .map((e) => QuickSalesDetailModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$QuickSalesModelToJson(QuickSalesModel instance) =>
    <String, dynamic>{
      'quick_sales_id': instance.quickSalesId,
      'quick_sales_date': instance.quickSalesDate,
      'customer_id': instance.customerId,
      'area_id': instance.areaId,
      'sales_id': instance.salesId,
      'payment_type': instance.paymentType,
      'source_id': instance.sourceId,
      'warehouse_id': instance.warehouseId,
      'currency_id': instance.currencyId,
      'rate': instance.rate,
      'sub_total': instance.subTotal,
      'discount': instance.discount,
      'total': instance.total,
      'grand_total': instance.grandTotal,
      'notes': instance.notes,
      'void': instance.isVoid,
      'status': instance.status,
      'destination_address': instance.destinationAddress,
      'sales_type': instance.salesType,
      'user_record': instance.userRecord,
      'dt_record': instance.dtRecord,
      'customer': instance.customer?.toJson(),
      'sales': instance.sales?.toJson(),
      'warehouse': instance.warehouse?.toJson(),
      'area': instance.area?.toJson(),
      'source': instance.source?.toJson(),
      'details': instance.details.map((e) => e.toJson()).toList(),
    };

QuickCustomerModel _$QuickCustomerModelFromJson(Map<String, dynamic> json) =>
    QuickCustomerModel(
      noAcc6: json['no_acc6'] as String,
      name: json['nm_acc6'] as String,
    );

Map<String, dynamic> _$QuickCustomerModelToJson(QuickCustomerModel instance) =>
    <String, dynamic>{'no_acc6': instance.noAcc6, 'nm_acc6': instance.name};

QuickSalesPersonModel _$QuickSalesPersonModelFromJson(
  Map<String, dynamic> json,
) => QuickSalesPersonModel(
  noAcc6: json['no_acc6'] as String,
  name: json['nm_acc6'] as String,
);

Map<String, dynamic> _$QuickSalesPersonModelToJson(
  QuickSalesPersonModel instance,
) => <String, dynamic>{'no_acc6': instance.noAcc6, 'nm_acc6': instance.name};

QuickWarehouseModel _$QuickWarehouseModelFromJson(Map<String, dynamic> json) =>
    QuickWarehouseModel(
      warehouseId: json['warehouse_id'] as String,
      warehouseName: json['warehouse_name'] as String,
    );

Map<String, dynamic> _$QuickWarehouseModelToJson(
  QuickWarehouseModel instance,
) => <String, dynamic>{
  'warehouse_id': instance.warehouseId,
  'warehouse_name': instance.warehouseName,
};

QuickAreaModel _$QuickAreaModelFromJson(Map<String, dynamic> json) =>
    QuickAreaModel(
      areaId: json['area_id'] as String,
      areaName: json['area_name'] as String,
    );

Map<String, dynamic> _$QuickAreaModelToJson(QuickAreaModel instance) =>
    <String, dynamic>{
      'area_id': instance.areaId,
      'area_name': instance.areaName,
    };

QuickSourceModel _$QuickSourceModelFromJson(Map<String, dynamic> json) =>
    QuickSourceModel(
      sourceId: json['source_id'] as String,
      sourceName: json['source_name'] as String,
    );

Map<String, dynamic> _$QuickSourceModelToJson(QuickSourceModel instance) =>
    <String, dynamic>{
      'source_id': instance.sourceId,
      'source_name': instance.sourceName,
    };

QuickSalesDetailModel _$QuickSalesDetailModelFromJson(
  Map<String, dynamic> json,
) => QuickSalesDetailModel(
  quickSalesId: json['quick_sales_id'] as String,
  index: (json['index'] as num).toInt(),
  inventoryId: json['inventory_id'] as String,
  isVoid: (json['void'] as num).toInt(),
  uomId: json['uom_id'] as String,
  uomId2: json['uom_id2'] as String,
  qty: json['qty'] as num,
  qty2: json['qty2'] as num,
  price: json['price'] as num,
  subTotal: json['sub_total'] as num,
  grandTotal: json['grand_total'] as num,
  notes: json['notes'] as String,
  userRecord: json['user_record'] as String,
  dtRecord: json['dt_record'] as String,
  inventory: json['inventory'] == null
      ? null
      : QuickInventoryModel.fromJson(json['inventory'] as Map<String, dynamic>),
  uom: json['uom'] == null
      ? null
      : QuickUomModel.fromJson(json['uom'] as Map<String, dynamic>),
  uom2: json['uom2'] == null
      ? null
      : QuickUomModel.fromJson(json['uom2'] as Map<String, dynamic>),
);

Map<String, dynamic> _$QuickSalesDetailModelToJson(
  QuickSalesDetailModel instance,
) => <String, dynamic>{
  'quick_sales_id': instance.quickSalesId,
  'index': instance.index,
  'inventory_id': instance.inventoryId,
  'void': instance.isVoid,
  'uom_id': instance.uomId,
  'uom_id2': instance.uomId2,
  'qty': instance.qty,
  'qty2': instance.qty2,
  'price': instance.price,
  'sub_total': instance.subTotal,
  'grand_total': instance.grandTotal,
  'notes': instance.notes,
  'user_record': instance.userRecord,
  'dt_record': instance.dtRecord,
  'inventory': instance.inventory?.toJson(),
  'uom': instance.uom?.toJson(),
  'uom2': instance.uom2?.toJson(),
};

QuickInventoryModel _$QuickInventoryModelFromJson(Map<String, dynamic> json) =>
    QuickInventoryModel(
      inventoryId: json['inventory_id'] as String,
      inventoryName: json['inventory_name'] as String,
    );

Map<String, dynamic> _$QuickInventoryModelToJson(
  QuickInventoryModel instance,
) => <String, dynamic>{
  'inventory_id': instance.inventoryId,
  'inventory_name': instance.inventoryName,
};

QuickUomModel _$QuickUomModelFromJson(Map<String, dynamic> json) =>
    QuickUomModel(
      uomId: json['uom_id'] as String,
      uomName: json['uom_name'] as String,
    );

Map<String, dynamic> _$QuickUomModelToJson(QuickUomModel instance) =>
    <String, dynamic>{'uom_id': instance.uomId, 'uom_name': instance.uomName};
