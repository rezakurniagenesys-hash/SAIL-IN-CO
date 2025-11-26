// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerData _$CustomerDataFromJson(Map<String, dynamic> json) => CustomerData(
  customerData: (json['customerData'] as List<dynamic>?)
      ?.map((e) => CustomerItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: json['pagination'] == null
      ? null
      : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
  filters: json['filters'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$CustomerDataToJson(CustomerData instance) =>
    <String, dynamic>{
      'customerData': instance.customerData,
      'pagination': instance.pagination,
      'filters': instance.filters,
    };
