import 'package:json_annotation/json_annotation.dart';

part 'payment_method_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PaymentMethodResponse {
  final bool status;
  final String message;
  final List<PaymentMethodData> data;

  PaymentMethodResponse({required this.status, required this.message, required this.data});

  factory PaymentMethodResponse.fromJson(Map<String, dynamic> json) => _$PaymentMethodResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodResponseToJson(this);
}

@JsonSerializable()
class PaymentMethodData {
  @JsonKey(name: 'slip_id')
  final String slipId;

  @JsonKey(name: 'slip_name')
  final String slipName;

  @JsonKey(name: 'slip_type')
  final String slipType;

  @JsonKey(name: 'currency_id')
  final String currencyId;
  
  @JsonKey(name: 'sales_acc_code')
  final String salesAccCode;



  PaymentMethodData({required this.slipId, required this.slipName, required this.slipType, required this.currencyId, required this.salesAccCode});
  factory PaymentMethodData.fromJson(Map<String, dynamic> json) => _$PaymentMethodDataFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodDataToJson(this);
}
