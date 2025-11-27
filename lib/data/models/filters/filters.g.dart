// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Filters _$FiltersFromJson(Map<String, dynamic> json) => Filters(
  customerId: json['customer_id'] as String?,
  search: json['search'] as String?,
  status: (json['status'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  salesId: json['sales_id'] as String?,
  date: json['date'] as String?,
);

Map<String, dynamic> _$FiltersToJson(Filters instance) => <String, dynamic>{
  'customer_id': instance.customerId,
  'search': instance.search,
  'status': instance.status,
  'sales_id': instance.salesId,
  'date': instance.date,
};
