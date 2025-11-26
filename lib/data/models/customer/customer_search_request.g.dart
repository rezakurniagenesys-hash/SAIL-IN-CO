// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_search_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerSearchRequest _$CustomerSearchRequestFromJson(
  Map<String, dynamic> json,
) => CustomerSearchRequest(
  page: (json['page'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
  customerId: json['customer_id'] as String?,
  search: json['search'] as String?,
  status: (json['status'] as num?)?.toInt(),
);

Map<String, dynamic> _$CustomerSearchRequestToJson(
  CustomerSearchRequest instance,
) => <String, dynamic>{
  'page': ?instance.page,
  'limit': ?instance.limit,
  'customer_id': ?instance.customerId,
  'search': ?instance.search,
  'status': ?instance.status,
};
