import 'package:json_annotation/json_annotation.dart';

part 'quick_sales_detail_response.g.dart';

/// ===============================
/// ROOT
/// ===============================
@JsonSerializable(explicitToJson: true)
class QuickSalesDetailResponse {
  final bool status;
  final String message;
  final QuickSalesDetailData data;

  QuickSalesDetailResponse({required this.status, required this.message, required this.data});

  factory QuickSalesDetailResponse.fromJson(Map<String, dynamic> json) => _$QuickSalesDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuickSalesDetailResponseToJson(this);
}

/// ===============================
/// DATA  👉 INI KUNCI UTAMA
/// ===============================
@JsonSerializable(explicitToJson: true)
class QuickSalesDetailData {
  @JsonKey(name: 'quickSales')
  final QuickSales quickSales;

  QuickSalesDetailData({required this.quickSales});

  factory QuickSalesDetailData.fromJson(Map<String, dynamic> json) => _$QuickSalesDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$QuickSalesDetailDataToJson(this);
}

/// ===============================
/// QUICK SALES
/// ===============================
@JsonSerializable(explicitToJson: true)
class QuickSales {
  @JsonKey(name: 'quick_sales_id')
  final String quickSalesId;

  @JsonKey(name: 'quick_sales_date')
  final String quickSalesDate;

  @JsonKey(name: 'po_id')
  final dynamic poId;

  @JsonKey(name: 'customer_id')
  final String customerId;

  @JsonKey(name: 'customer_id_detail')
  final dynamic customerIdDetail;

  @JsonKey(name: 'expired_date')
  final dynamic expiredDate;

  @JsonKey(name: 'quotation_id')
  final dynamic quotationId;

  @JsonKey(name: 'is_sample')
  final dynamic isSample;

  @JsonKey(name: 'area_id')
  final String areaId;

  final dynamic outletId;
  final dynamic zonaId;

  @JsonKey(name: 'sales_id')
  final String salesId;

  final dynamic transportationType;
  final dynamic shippingType;
  final dynamic longTerm;
  final dynamic longTerm2;
  final dynamic isGuarantee;

  @JsonKey(name: 'payment_type')
  final int paymentType;

  @JsonKey(name: 'source_id')
  final String sourceId;

  @JsonKey(name: 'warehouse_id')
  final String warehouseId;

  @JsonKey(name: 'currency_id')
  final String currencyId;

  final String rate;

  @JsonKey(name: 'rounding_type')
  final dynamic roundingType;

  @JsonKey(name: 'vat_include')
  final dynamic vatInclude;

  @JsonKey(name: 'sub_total')
  final String subTotal;

  final String discount;

  @JsonKey(name: 'vat_value')
  final dynamic vatValue;

  @JsonKey(name: 'vat2_value')
  final dynamic vat2Value;

  @JsonKey(name: 'dp_percentage')
  final dynamic dpPercentage;

  @JsonKey(name: 'dp_value')
  final dynamic dpValue;

  final String total;

  @JsonKey(name: 'grand_total')
  final String grandTotal;

  final String notes;

  @JsonKey(name: 'void')
  final int voidStatus;

  @JsonKey(name: 'void_notes')
  final dynamic voidNotes;

  final int status;
  final int close;

  @JsonKey(name: 'approve_date')
  final dynamic approveDate;

  @JsonKey(name: 'approve_user')
  final dynamic approveUser;

  @JsonKey(name: 'approve2_date')
  final dynamic approve2Date;

  @JsonKey(name: 'approve2_user')
  final dynamic approve2User;

  @JsonKey(name: 'destination_address')
  final String destinationAddress;

  @JsonKey(name: 'billing_address')
  final dynamic billingAddress;

  @JsonKey(name: 'project_type')
  final dynamic projectType;

  @JsonKey(name: 'project_name')
  final dynamic projectName;

  @JsonKey(name: 'purchasing_commission')
  final dynamic purchasingCommission;

  @JsonKey(name: 'invoice_id')
  final dynamic invoiceId;

  @JsonKey(name: 'invoice_date')
  final dynamic invoiceDate;

  @JsonKey(name: 'tax_number')
  final dynamic taxNumber;

  final int replacement;

  @JsonKey(name: 'count_csv')
  final int countCsv;

  @JsonKey(name: 'dt_record')
  final String dtRecord;

  @JsonKey(name: 'user_record')
  final String userRecord;

  final dynamic dtModified;
  final dynamic userModified;
  final dynamic npwp;

  @JsonKey(name: 'sales_type')
  final int salesType;

  final dynamic rounding;

  @JsonKey(name: 'vat_percentage')
  final dynamic vatPercentage;

  final dynamic jobId;
  final dynamic startDate;
  final dynamic endDate;

  @JsonKey(name: 'count_revision')
  final int countRevision;

  final dynamic pathImage;

  @JsonKey(name: 'customer_no_acc6')
  final String customerNoAcc6;

  @JsonKey(name: 'customer_nm_acc6')
  final String customerNmAcc6;

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

  @JsonKey(name: 'customer_group_name')
  final dynamic customerGroupName;

  @JsonKey(name: 'company_name')
  final dynamic companyName;

  @JsonKey(name: 'company_address')
  final dynamic companyAddress;

  @JsonKey(name: 'company_logo')
  final dynamic companyLogo;

  final dynamic customer;
  final dynamic sales;
  final dynamic warehouse;
  final dynamic area;
  final dynamic source;

  final List<QuickSalesDetail> details;

  QuickSales({
    required this.quickSalesId,
    required this.quickSalesDate,
    required this.poId,
    required this.customerId,
    required this.customerIdDetail,
    required this.expiredDate,
    required this.quotationId,
    required this.isSample,
    required this.areaId,
    required this.outletId,
    required this.zonaId,
    required this.salesId,
    required this.transportationType,
    required this.shippingType,
    required this.longTerm,
    required this.longTerm2,
    required this.isGuarantee,
    required this.paymentType,
    required this.sourceId,
    required this.warehouseId,
    required this.currencyId,
    required this.rate,
    required this.roundingType,
    required this.vatInclude,
    required this.subTotal,
    required this.discount,
    required this.vatValue,
    required this.vat2Value,
    required this.dpPercentage,
    required this.dpValue,
    required this.total,
    required this.grandTotal,
    required this.notes,
    required this.voidStatus,
    required this.voidNotes,
    required this.status,
    required this.close,
    required this.approveDate,
    required this.approveUser,
    required this.approve2Date,
    required this.approve2User,
    required this.destinationAddress,
    required this.billingAddress,
    required this.projectType,
    required this.projectName,
    required this.purchasingCommission,
    required this.invoiceId,
    required this.invoiceDate,
    required this.taxNumber,
    required this.replacement,
    required this.countCsv,
    required this.dtRecord,
    required this.userRecord,
    required this.dtModified,
    required this.userModified,
    required this.npwp,
    required this.salesType,
    required this.rounding,
    required this.vatPercentage,
    required this.jobId,
    required this.startDate,
    required this.endDate,
    required this.countRevision,
    required this.pathImage,
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
    required this.customerGroupName,
    required this.companyName,
    required this.companyAddress,
    required this.companyLogo,
    required this.customer,
    required this.sales,
    required this.warehouse,
    required this.area,
    required this.source,
    required this.details,
  });

  factory QuickSales.fromJson(Map<String, dynamic> json) => _$QuickSalesFromJson(json);

  Map<String, dynamic> toJson() => _$QuickSalesToJson(this);
}

/// ===============================
/// DETAIL
/// ===============================
@JsonSerializable()
class QuickSalesDetail {
  @JsonKey(name: 'quick_sales_id')
  final String quickSalesId;

  final int index;

  @JsonKey(name: 'description_index')
  final dynamic descriptionIndex;

  @JsonKey(name: 'inventory_id')
  final String inventoryId;

  @JsonKey(name: 'void')
  final int voidStatus;

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
  final String price2;

  @JsonKey(name: 'hpp_price')
  final String hppPrice;

  @JsonKey(name: 'disc_value')
  final String discValue;

  @JsonKey(name: 'disc2_value')
  final dynamic disc2Value;

  @JsonKey(name: 'sub_total')
  final String subTotal;

  @JsonKey(name: 'vat_value')
  final String vatValue;

  final dynamic taxId;
  final dynamic taxPercentage;
  final dynamic taxValue;

  @JsonKey(name: 'grand_total')
  final String grandTotal;

  final String notes;

  @JsonKey(name: 'dt_record')
  final String dtRecord;

  @JsonKey(name: 'user_record')
  final String userRecord;

  @JsonKey(name: 'dt_modified')
  final dynamic dtModified;

  @JsonKey(name: 'user_modified')
  final dynamic userModified;

  @JsonKey(name: 'qty_customer')
  final dynamic qtyCustomer;

  @JsonKey(name: 'DiscPercentage_value')
  final dynamic discPercentageValue;

  // final String inventoryName;
  // final String uomName;
  // final String uomName2;

  final InventoryRefModel inventory;
  final UomRefModel uom;
  final UomRefModel uom2;

  QuickSalesDetail({
    required this.quickSalesId,
    required this.index,
    required this.descriptionIndex,
    required this.inventoryId,
    required this.voidStatus,
    required this.voidNotes,
    required this.uomId,
    required this.uomId2,
    required this.qty,
    required this.qty2,
    required this.disc,
    required this.price,
    required this.price2,
    required this.hppPrice,
    required this.discValue,
    required this.disc2Value,
    required this.subTotal,
    required this.vatValue,
    required this.taxId,
    required this.taxPercentage,
    required this.taxValue,
    required this.grandTotal,
    required this.notes,
    required this.dtRecord,
    required this.userRecord,
    required this.dtModified,
    required this.userModified,
    required this.qtyCustomer,
    required this.discPercentageValue,
    // required this.inventoryName,
    // required this.uomName,
    // required this.uomName2,
    required this.inventory,
    required this.uom,
    required this.uom2,
  });

  factory QuickSalesDetail.fromJson(Map<String, dynamic> json) => _$QuickSalesDetailFromJson(json);

  Map<String, dynamic> toJson() => _$QuickSalesDetailToJson(this);
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
