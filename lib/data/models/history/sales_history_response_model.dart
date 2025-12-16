import 'package:json_annotation/json_annotation.dart';

part 'sales_history_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SalesHistoryResponseModel {
  @JsonKey(name: 'status')
  final bool status;

  final String message;
  final SalesHistoryData data;

  SalesHistoryResponseModel({required this.status, required this.message, required this.data});

  factory SalesHistoryResponseModel.fromJson(Map<String, dynamic> json) => _$SalesHistoryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalesHistoryResponseModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SalesHistoryData {
  final List<SalesHistoryItem> sales;
  final SalesHistoryPagination pagination;

  SalesHistoryData({required this.sales, required this.pagination});

  factory SalesHistoryData.fromJson(Map<String, dynamic> json) => _$SalesHistoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$SalesHistoryDataToJson(this);
}

@JsonSerializable()
class SalesHistoryItem {
  @JsonKey(name: 'transaction_id')
  final String transactionId;

  @JsonKey(name: 'transaction_type')
  final String transactionType;

  @JsonKey(name: 'transaction_date')
  final String transactionDate;

  @JsonKey(name: 'customer_id')
  final String customerId;

  @JsonKey(name: 'total_qty')
  final int totalQty;

  @JsonKey(name: 'inventory_names')
  final String inventoryNames;

  @JsonKey(name: 'shipping_id')
  final dynamic shippingId;

  @JsonKey(name: 'invoice_id')
  final dynamic invoiceId;

  SalesHistoryItem({
    required this.transactionId,
    required this.transactionType,
    required this.transactionDate,
    required this.customerId,
    required this.totalQty,
    required this.inventoryNames,
    this.shippingId,
    this.invoiceId,
  });

  factory SalesHistoryItem.fromJson(Map<String, dynamic> json) => _$SalesHistoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$SalesHistoryItemToJson(this);
}

@JsonSerializable()
class SalesHistoryPagination {
  final int page;
  final int limit;
  final int total;
  final int totalPages;
  final bool hasNext;
  final bool hasPrev;

  SalesHistoryPagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrev,
  });

  factory SalesHistoryPagination.fromJson(Map<String, dynamic> json) => _$SalesHistoryPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$SalesHistoryPaginationToJson(this);
}
