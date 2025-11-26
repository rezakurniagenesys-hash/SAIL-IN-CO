import 'package:json_annotation/json_annotation.dart';
import 'package:sail_in_co/data/models/pagination/pagination.dart';
import 'customer_item.dart';

part 'customer_data.g.dart';

@JsonSerializable()
class CustomerData {
  @JsonKey(name: "customerData")
  final List<CustomerItem>? customerData;

  final Pagination? pagination;

  final Map<String, dynamic>? filters;

  CustomerData({
    this.customerData,
    this.pagination,
    this.filters,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) =>
      _$CustomerDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CustomerDataToJson(this);
}
