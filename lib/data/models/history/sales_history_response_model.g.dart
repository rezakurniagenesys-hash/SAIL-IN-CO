// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_history_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesHistoryResponseModel _$SalesHistoryResponseModelFromJson(
  Map<String, dynamic> json,
) => SalesHistoryResponseModel(
  status: json['status'] as bool,
  message: json['message'] as String,
  data: SalesHistoryData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SalesHistoryResponseModelToJson(
  SalesHistoryResponseModel instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data.toJson(),
};

SalesHistoryData _$SalesHistoryDataFromJson(Map<String, dynamic> json) =>
    SalesHistoryData(
      sales: (json['sales'] as List<dynamic>)
          .map((e) => SalesHistoryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: SalesHistoryPagination.fromJson(
        json['pagination'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$SalesHistoryDataToJson(SalesHistoryData instance) =>
    <String, dynamic>{
      'sales': instance.sales.map((e) => e.toJson()).toList(),
      'pagination': instance.pagination.toJson(),
    };

SalesHistoryItem _$SalesHistoryItemFromJson(Map<String, dynamic> json) =>
    SalesHistoryItem(
      transactionId: json['transaction_id'] as String,
      transactionType: json['transaction_type'] as String,
      transactionDate: json['transaction_date'] as String,
      customerId: json['customer_id'] as String,
      totalQty: (json['total_qty'] as num).toInt(),
      inventoryNames: json['inventory_names'] as String,
      shippingId: json['shipping_id'],
      invoiceId: json['invoice_id'],
    );

Map<String, dynamic> _$SalesHistoryItemToJson(SalesHistoryItem instance) =>
    <String, dynamic>{
      'transaction_id': instance.transactionId,
      'transaction_type': instance.transactionType,
      'transaction_date': instance.transactionDate,
      'customer_id': instance.customerId,
      'total_qty': instance.totalQty,
      'inventory_names': instance.inventoryNames,
      'shipping_id': instance.shippingId,
      'invoice_id': instance.invoiceId,
    };

SalesHistoryPagination _$SalesHistoryPaginationFromJson(
  Map<String, dynamic> json,
) => SalesHistoryPagination(
  page: (json['page'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
  total: (json['total'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  hasNext: json['hasNext'] as bool,
  hasPrev: json['hasPrev'] as bool,
);

Map<String, dynamic> _$SalesHistoryPaginationToJson(
  SalesHistoryPagination instance,
) => <String, dynamic>{
  'page': instance.page,
  'limit': instance.limit,
  'total': instance.total,
  'totalPages': instance.totalPages,
  'hasNext': instance.hasNext,
  'hasPrev': instance.hasPrev,
};
