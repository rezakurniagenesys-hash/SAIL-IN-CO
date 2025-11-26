import 'package:json_annotation/json_annotation.dart';
import 'customer_data.dart';

part 'customer_response_model.g.dart';

@JsonSerializable()
class CustomerResponseModel {
  final bool? status;
  final String? message;
  final CustomerData? data;

  CustomerResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory CustomerResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CustomerResponseModelToJson(this);
}
