import 'package:json_annotation/json_annotation.dart';

part 'shipping_sales_order_payload.g.dart';

@JsonSerializable()
class ShippingSalesOrderPayload {
  @JsonKey(name: 'sales_order_id')
  final String salesOrderId;

  @JsonKey(name: 'user_record')
  final String userRecord;

  ShippingSalesOrderPayload({required this.salesOrderId, required this.userRecord});

  factory ShippingSalesOrderPayload.fromJson(Map<String, dynamic> json) => _$ShippingSalesOrderPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingSalesOrderPayloadToJson(this);
}
