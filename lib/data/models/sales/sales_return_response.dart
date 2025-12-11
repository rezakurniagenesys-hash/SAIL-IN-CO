import 'package:json_annotation/json_annotation.dart';

part 'sales_return_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SalesReturnResponse {
  final bool status;
  final String message;
  final List<SalesReturnData> data;

  SalesReturnResponse({required this.status, required this.message, required this.data});

  factory SalesReturnResponse.fromJson(Map<String, dynamic> json) => _$SalesReturnResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SalesReturnResponseToJson(this);
}

@JsonSerializable()
class SalesReturnData {
  @JsonKey(name: 'sales_return_id')
  final String salesReturnId;

  final String sisa;

  SalesReturnData({required this.salesReturnId, required this.sisa});

  factory SalesReturnData.fromJson(Map<String, dynamic> json) => _$SalesReturnDataFromJson(json);

  Map<String, dynamic> toJson() => _$SalesReturnDataToJson(this);
}
