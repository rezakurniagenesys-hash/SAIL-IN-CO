import 'package:json_annotation/json_annotation.dart';

part 'stock_request.g.dart';

@JsonSerializable()
class StockRequest {
  @JsonKey(name: "warehouse_id")
  final String warehouseId;

  /// Format: YYYY-MM-DD
  final String? date;

  /// Optional: search query (ex: ?search=john)
  final String? search;

  StockRequest({
    required this.warehouseId,
    this.date,
    this.search,
  });

  /// Convert request to query params for GET request
  Map<String, dynamic> toQueryParams() {
    final params = <String, dynamic>{};

    if (date != null) params['date'] = date!;
    if (search != null && search!.isNotEmpty) params['search'] = search!;

    return params;
  }

  factory StockRequest.fromJson(Map<String, dynamic> json) =>
      _$StockRequestFromJson(json);

  Map<String, dynamic> toJson() => _$StockRequestToJson(this);
}
