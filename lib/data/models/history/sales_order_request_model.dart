import 'package:json_annotation/json_annotation.dart';

part 'sales_order_request_model.g.dart';

@JsonSerializable()
class SalesOrderRequestModel {
  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'customer_id')
  final String customerId;

  @JsonKey(name: 'void')
  final int voidFlag;

  final int status;

  @JsonKey(name: 'start_date')
  final String startDate;

  @JsonKey(name: 'end_date')
  final String endDate;

  final String search;

  final int page;
  final int limit;

  SalesOrderRequestModel({
    required this.userId,
    required this.customerId,
    required this.voidFlag,
    required this.status,
    required this.startDate,
    required this.endDate,
    this.search = '',
    this.page = 1,
    this.limit = 50,
  });

  /// For API body (if needed)
  Map<String, dynamic> toJson() => _$SalesOrderRequestModelToJson(this);

  /// For queryParameters → Dio/http
  Map<String, dynamic> toQuery() => {
    "user_id": userId,
    "customer_id": customerId,
    "void": voidFlag,
    "status": status,
    "start_date": startDate,
    "end_date": endDate,
    "search": search,
    "page": page,
    "limit": limit,
  };

  factory SalesOrderRequestModel.fromJson(Map<String, dynamic> json) => _$SalesOrderRequestModelFromJson(json);
}
