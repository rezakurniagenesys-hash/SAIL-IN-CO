import 'package:json_annotation/json_annotation.dart';
import 'package:sail_in_co/data/models/salesorder/sales_order_detail.dart';

part 'sales_order_payload_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SalesOrderPayloadModel {
  @JsonKey(name: 'sales_order_date')
  final String salesOrderDate;

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

  /// sebelumnya voidValue
  @JsonKey(name: 'voidvalue')
  final int isVoid;

  final int status;

  @JsonKey(name: 'destination_address')
  final String destinationAddress;

  @JsonKey(name: 'sales_type')
  final int salesType;

  @JsonKey(name: 'user_record')
  final String userRecord;

  final List<SalesOrderDetail> details;

  SalesOrderPayloadModel({
    required this.salesOrderDate,
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
    required this.details,
  });

  // --------------------------
  // COPY WITH
  // --------------------------
  SalesOrderPayloadModel copyWith({
    String? salesOrderDate,
    String? customerId,
    String? areaId,
    String? salesId,
    int? paymentType,
    String? sourceId,
    String? warehouseId,
    String? currencyId,
    num? rate,
    num? subTotal,
    num? discount,
    num? total,
    num? grandTotal,
    String? notes,
    int? isVoid,
    int? status,
    String? destinationAddress,
    int? salesType,
    String? userRecord,
    List<SalesOrderDetail>? details,
  }) {
    return SalesOrderPayloadModel(
      salesOrderDate: salesOrderDate ?? this.salesOrderDate,
      customerId: customerId ?? this.customerId,
      areaId: areaId ?? this.areaId,
      salesId: salesId ?? this.salesId,
      paymentType: paymentType ?? this.paymentType,
      sourceId: sourceId ?? this.sourceId,
      warehouseId: warehouseId ?? this.warehouseId,
      currencyId: currencyId ?? this.currencyId,
      rate: rate ?? this.rate,
      subTotal: subTotal ?? this.subTotal,
      discount: discount ?? this.discount,
      total: total ?? this.total,
      grandTotal: grandTotal ?? this.grandTotal,
      notes: notes ?? this.notes,
      isVoid: isVoid ?? this.isVoid,
      status: status ?? this.status,
      destinationAddress: destinationAddress ?? this.destinationAddress,
      salesType: salesType ?? this.salesType,
      userRecord: userRecord ?? this.userRecord,
      details: details ?? this.details,
    );
  }

  factory SalesOrderPayloadModel.fromJson(Map<String, dynamic> json) => _$SalesOrderPayloadModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalesOrderPayloadModelToJson(this);
}
