// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_history_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityHistoryResponseModel _$ActivityHistoryResponseModelFromJson(
  Map<String, dynamic> json,
) => ActivityHistoryResponseModel(
  status: json['status'] as bool,
  message: json['message'] as String,
  data: ActivityHistoryData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ActivityHistoryResponseModelToJson(
  ActivityHistoryResponseModel instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

ActivityHistoryData _$ActivityHistoryDataFromJson(Map<String, dynamic> json) =>
    ActivityHistoryData(
      transactions: (json['transactions'] as List<dynamic>)
          .map(
            (e) =>
                ActivityHistoryTransaction.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      pagination: ActivityHistoryPagination.fromJson(
        json['pagination'] as Map<String, dynamic>,
      ),
      filters: ActivityHistoryFilters.fromJson(
        json['filters'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ActivityHistoryDataToJson(
  ActivityHistoryData instance,
) => <String, dynamic>{
  'transactions': instance.transactions,
  'pagination': instance.pagination,
  'filters': instance.filters,
};

ActivityHistoryTransaction _$ActivityHistoryTransactionFromJson(
  Map<String, dynamic> json,
) => ActivityHistoryTransaction(
  salesId: json['sales_id'] as String,
  transactionDate: json['transaction_date'] as String,
  shippingId: json['shipping_id'],
  lastUpdate: json['last_update'],
  totalQty: json['total_qty'],
  totalQty2: json['total_qty2'],
  grandTotal: json['grand_total'] as num,
  transactionType: json['transaction_type'] as String,
  flagPaid: (json['flag_paid'] as num).toInt(),
  inventoryNames: json['inventory_names'],
);

Map<String, dynamic> _$ActivityHistoryTransactionToJson(
  ActivityHistoryTransaction instance,
) => <String, dynamic>{
  'sales_id': instance.salesId,
  'transaction_date': instance.transactionDate,
  'shipping_id': instance.shippingId,
  'last_update': instance.lastUpdate,
  'total_qty': instance.totalQty,
  'total_qty2': instance.totalQty2,
  'grand_total': instance.grandTotal,
  'transaction_type': instance.transactionType,
  'flag_paid': instance.flagPaid,
  'inventory_names': instance.inventoryNames,
};

ActivityHistoryPagination _$ActivityHistoryPaginationFromJson(
  Map<String, dynamic> json,
) => ActivityHistoryPagination(
  page: (json['page'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
  total: (json['total'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  hasNext: json['hasNext'] as bool,
  hasPrev: json['hasPrev'] as bool,
);

Map<String, dynamic> _$ActivityHistoryPaginationToJson(
  ActivityHistoryPagination instance,
) => <String, dynamic>{
  'page': instance.page,
  'limit': instance.limit,
  'total': instance.total,
  'totalPages': instance.totalPages,
  'hasNext': instance.hasNext,
  'hasPrev': instance.hasPrev,
};

ActivityHistoryFilters _$ActivityHistoryFiltersFromJson(
  Map<String, dynamic> json,
) => ActivityHistoryFilters(
  startDate: json['start_date'] as String,
  endDate: json['end_date'] as String,
  userId: json['user_id'],
  search: json['search'] as String,
  type: json['type'] as String,
  salesId: json['sales_id'] as String,
  salesDate: json['sales_date'] as String,
  inventoryName: json['inventory_name'] as String,
);

Map<String, dynamic> _$ActivityHistoryFiltersToJson(
  ActivityHistoryFilters instance,
) => <String, dynamic>{
  'start_date': instance.startDate,
  'end_date': instance.endDate,
  'user_id': instance.userId,
  'search': instance.search,
  'type': instance.type,
  'sales_id': instance.salesId,
  'sales_date': instance.salesDate,
  'inventory_name': instance.inventoryName,
};
