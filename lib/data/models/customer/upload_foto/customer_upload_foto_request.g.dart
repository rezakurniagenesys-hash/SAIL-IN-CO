// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_upload_foto_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerUploadFotoRequest _$CustomerUploadFotoRequestFromJson(
  Map<String, dynamic> json,
) => CustomerUploadFotoRequest(
  latitude: json['latitude'] as String,
  longitude: json['longitude'] as String,
  address: json['address'] as String,
  statusVisit: (json['status_visit'] as num).toInt(),
  userModified: json['user_modified'] as String,
);

Map<String, dynamic> _$CustomerUploadFotoRequestToJson(
  CustomerUploadFotoRequest instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'address': instance.address,
  'status_visit': instance.statusVisit,
  'user_modified': instance.userModified,
};
