// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerDetailResponse _$CustomerDetailResponseFromJson(
  Map<String, dynamic> json,
) => CustomerDetailResponse(
  status: json['status'] as bool?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : CustomerDetailData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CustomerDetailResponseToJson(
  CustomerDetailResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

CustomerDetailData _$CustomerDetailDataFromJson(Map<String, dynamic> json) =>
    CustomerDetailData(
      customer: json['customer'] == null
          ? null
          : CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CustomerDetailDataToJson(CustomerDetailData instance) =>
    <String, dynamic>{'customer': instance.customer};

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel(
      noAcc6: json['no_acc6'] as String?,
      name: json['nm_acc6'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      province: json['province'] as String?,
      city: json['city'] as String?,
      district: json['district'] as String?,
      subDistrict: json['sub_district'] as String?,
      nik: json['nik'] as String?,
      creditLimit: json['credit_limit'] as String?,
      defaultPayment: json['default_payment'] as String?,
      areaId: json['area_id'] as String?,
      typeCustomer: json['type_customer'] as String?,
      areaName: json['area_name'] as String?,
      statusVisit: (json['status_visit'] as num?)?.toInt(),
      linkPath: json['link_path'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      visitAddress: json['visit_address'] as String?,
      visitDate: json['visit_date'] == null
          ? null
          : DateTime.parse(json['visit_date'] as String),
      reason: json['reason'] as String?,
      visitNotes: json['visit_notes'] as String?,
    );

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'no_acc6': instance.noAcc6,
      'nm_acc6': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'province': instance.province,
      'city': instance.city,
      'district': instance.district,
      'sub_district': instance.subDistrict,
      'nik': instance.nik,
      'credit_limit': instance.creditLimit,
      'default_payment': instance.defaultPayment,
      'area_id': instance.areaId,
      'type_customer': instance.typeCustomer,
      'area_name': instance.areaName,
      'status_visit': instance.statusVisit,
      'link_path': instance.linkPath,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'visit_address': instance.visitAddress,
      'visit_date': instance.visitDate?.toIso8601String(),
      'reason': instance.reason,
      'visit_notes': instance.visitNotes,
    };
