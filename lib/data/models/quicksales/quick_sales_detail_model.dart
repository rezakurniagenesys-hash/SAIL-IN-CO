import 'package:json_annotation/json_annotation.dart';

part 'quick_sales_detail_model.g.dart';

@JsonSerializable()
class QuickSalesDetailModel {
  final int index;

  @JsonKey(name: 'inventory_id')
  final String inventoryId;

  @JsonKey(name: 'voidvalue')
  final int isVoid;

  @JsonKey(name: 'uom_id')
  final String uomId;

  @JsonKey(name: 'uom_id2')
  final String uomId2;

  final num qty;
  final num qty2;
  final num price;

  /// Tambahan baru
  @JsonKey(name: 'price2')
  final num price2;

  @JsonKey(name: 'vat_value')
  final num vatValue;

  @JsonKey(name: 'disc_value')
  final num discValue;

  @JsonKey(name: 'sub_total')
  final num subTotal;

  @JsonKey(name: 'grand_total')
  final num grandTotal;

  final String notes;

  @JsonKey(name: 'user_record')
  final String userRecord;

  QuickSalesDetailModel({
    required this.index,
    required this.inventoryId,
    required this.isVoid,
    required this.uomId,
    required this.uomId2,
    required this.qty,
    required this.qty2,
    required this.price,
    required this.price2, // NEW
    required this.vatValue, // NEW
    required this.discValue, // NEW
    required this.subTotal,
    required this.grandTotal,
    required this.notes,
    required this.userRecord,
  });

  factory QuickSalesDetailModel.fromJson(Map<String, dynamic> json) => _$QuickSalesDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuickSalesDetailModelToJson(this);
}
