import 'package:json_annotation/json_annotation.dart';

part 'activity_history_response_model.g.dart';

@JsonSerializable()
class ActivityHistoryResponseModel {
  final bool status;
  final String message;
  final ActivityHistoryData data;

  ActivityHistoryResponseModel({required this.status, required this.message, required this.data});

  factory ActivityHistoryResponseModel.fromJson(Map<String, dynamic> json) => _$ActivityHistoryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityHistoryResponseModelToJson(this);
}

@JsonSerializable()
class ActivityHistoryData {
  final List<ActivityHistoryTransaction> transactions;
  final ActivityHistoryPagination pagination;
  final ActivityHistoryFilters filters;

  ActivityHistoryData({required this.transactions, required this.pagination, required this.filters});

  factory ActivityHistoryData.fromJson(Map<String, dynamic> json) => _$ActivityHistoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityHistoryDataToJson(this);
}

@JsonSerializable()
class ActivityHistoryTransaction {
  @JsonKey(name: 'sales_id')
  final String salesId;

  @JsonKey(name: 'transaction_date')
  final String transactionDate;

  @JsonKey(name: 'shipping_id')
  final dynamic shippingId;

  @JsonKey(name: 'last_update')
  final dynamic lastUpdate;

  @JsonKey(name: 'total_qty')
  final dynamic totalQty;

  @JsonKey(name: 'total_qty2')
  final dynamic totalQty2;

  @JsonKey(name: 'grand_total')
  final num grandTotal;

  @JsonKey(name: 'transaction_type')
  final String transactionType;

  @JsonKey(name: 'flag_paid')
  final int flagPaid;

  @JsonKey(name: 'inventory_names')
  final dynamic inventoryNames;

  ActivityHistoryTransaction({
    required this.salesId,
    required this.transactionDate,
    required this.shippingId,
    required this.lastUpdate,
    required this.totalQty,
    required this.totalQty2,
    required this.grandTotal,
    required this.transactionType,
    required this.flagPaid,
    required this.inventoryNames,
  });

  factory ActivityHistoryTransaction.fromJson(Map<String, dynamic> json) => _$ActivityHistoryTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityHistoryTransactionToJson(this);
}

@JsonSerializable()
class ActivityHistoryPagination {
  final int page;
  final int limit;
  final int total;

  @JsonKey(name: 'totalPages')
  final int totalPages;

  @JsonKey(name: 'hasNext')
  final bool hasNext;

  @JsonKey(name: 'hasPrev')
  final bool hasPrev;

  ActivityHistoryPagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrev,
  });

  factory ActivityHistoryPagination.fromJson(Map<String, dynamic> json) => _$ActivityHistoryPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityHistoryPaginationToJson(this);
}

@JsonSerializable()
class ActivityHistoryFilters {
  @JsonKey(name: 'start_date')
  final String startDate;

  @JsonKey(name: 'end_date')
  final String endDate;

  @JsonKey(name: 'user_id')
  final String userId;

  final String search;
  final String type;

  @JsonKey(name: 'sales_id')
  final String salesId;

  @JsonKey(name: 'sales_date')
  final String salesDate;

  @JsonKey(name: 'inventory_name')
  final String inventoryName;

  ActivityHistoryFilters({
    required this.startDate,
    required this.endDate,
    required this.userId,
    required this.search,
    required this.type,
    required this.salesId,
    required this.salesDate,
    required this.inventoryName,
  });

  factory ActivityHistoryFilters.fromJson(Map<String, dynamic> json) => _$ActivityHistoryFiltersFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityHistoryFiltersToJson(this);
}
