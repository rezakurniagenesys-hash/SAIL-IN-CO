import 'package:json_annotation/json_annotation.dart';

part 'history_transaction_payload_model.g.dart';

@JsonSerializable(includeIfNull: false)
class HistoryTransactionPayloadModel {
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'customer_id')
  final String customerId;

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'start_date')
  final String startDate;

  @JsonKey(name: 'end_date')
  final String endDate;

  final int page;
  final int limit;

  @JsonKey(name: 'sales_date')
  final String? salesDate;

  @JsonKey(name: 'search')
  final String? search;

  HistoryTransactionPayloadModel({
    required this.userId,
    required this.customerId,
    this.type,
    required this.startDate,
    required this.endDate,
    required this.page,
    required this.limit,
    this.salesDate,
    this.search,
  });

  /// ===============================
  /// COPY WITH
  /// ===============================
  HistoryTransactionPayloadModel copyWith({
    String? userId,
    String? customerId,
    String? type,
    String? startDate,
    String? endDate,
    int? page,
    int? limit,
    String? salesId,
    String? salesDate,
    String? inventoryName,
    String? search,
  }) {
    return HistoryTransactionPayloadModel(
      userId: userId ?? this.userId,
      customerId: customerId ?? this.customerId,
      type: type ?? this.type,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      salesDate: salesDate ?? this.salesDate,
      search: search ?? this.search,
    );
  }

  /// ===============================
  /// TO QUERY PARAMS
  /// ===============================
  Map<String, dynamic> toQuery() {
    final Map<String, dynamic> query = {
      'user_id': userId,
      'customer_id': customerId,
      'start_date': startDate,
      'end_date': endDate,
      'page': page,
      'limit': limit,
    };

    if (type != null && type!.isNotEmpty) {
      query['type'] = type;
    }
    if (salesDate != null && salesDate!.isNotEmpty) {
      query['sales_date'] = salesDate;
    }

    if (search != null && search!.isNotEmpty) {
      query['search'] = search;
    }

    return query;
  }

  factory HistoryTransactionPayloadModel.fromJson(Map<String, dynamic> json) => _$HistoryTransactionPayloadModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryTransactionPayloadModelToJson(this);
}
