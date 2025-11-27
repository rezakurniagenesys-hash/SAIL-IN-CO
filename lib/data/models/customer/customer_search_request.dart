import 'package:json_annotation/json_annotation.dart';

part 'customer_search_request.g.dart';

@JsonSerializable(includeIfNull: false)
class CustomerSearchRequest {
  final int? page;
  final int? limit;

  @JsonKey(name: "customer_id")
  final String? customerId;
  @JsonKey(name: "sales_id")
  final String? salesId;

  final String? search;
  final String? date;
  final int? status;

  CustomerSearchRequest({this.page, this.limit, this.customerId, this.salesId, this.search, this.date, this.status});

  /// Convert JSON → Model
  factory CustomerSearchRequest.fromJson(Map<String, dynamic> json) => _$CustomerSearchRequestFromJson(json);

  /// Convert Model → JSON (for sending as body)
  Map<String, dynamic> toJson() => _$CustomerSearchRequestToJson(this);

  /// Convert Model → Query Parameters (untuk Dio GET)
  Map<String, dynamic> toQuery() {
    final map = toJson();

    // Hapus field empty string („“) supaya tidak ikut query
    map.removeWhere((key, value) => value == null || (value is String && value.trim().isEmpty));

    return map;
  }
}
