import 'package:json_annotation/json_annotation.dart';

part 'filters.g.dart';

@JsonSerializable(explicitToJson: true)
class Filters {
  @JsonKey(name: "customer_id")
  final String? customerId;

  final String? search;

  /// status berupa list (ex: [0,1])
  final List<int>? status;

  @JsonKey(name: "sales_id")
  final String? salesId;

  final String? date;

  Filters({
    this.customerId,
    this.search,
    this.status,
    this.salesId,
    this.date,
  });

  factory Filters.fromJson(Map<String, dynamic> json) =>
      _$FiltersFromJson(json);

  Map<String, dynamic> toJson() => _$FiltersToJson(this);
}
