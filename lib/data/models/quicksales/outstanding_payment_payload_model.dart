import 'package:json_annotation/json_annotation.dart';

part 'outstanding_payment_payload_model.g.dart';

@JsonSerializable()
class OutstandingPaymentPayloadModel {
  @JsonKey(name: 'invoice_id')
  final String invoiceId;

  @JsonKey(name: 'slip_id')
  final String slipId;

  @JsonKey(name: 'sales_return_id')
  final String salesReturnId;

  @JsonKey(name: 'sales_return_payment')
  final num salesReturnPayment;

  @JsonKey(name: 'remaining_payment')
  final num remainingPayment;

  @JsonKey(name: 'user_record')
  final String userRecord;

  OutstandingPaymentPayloadModel({
    required this.invoiceId,
    required this.slipId,
    required this.salesReturnId,
    required this.salesReturnPayment,
    required this.remainingPayment,
    required this.userRecord,
  });

  factory OutstandingPaymentPayloadModel.fromJson(Map<String, dynamic> json) =>
      _$OutstandingPaymentPayloadModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$OutstandingPaymentPayloadModelToJson(this);
}
