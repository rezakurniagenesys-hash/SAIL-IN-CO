// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_upload_foto_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerUploadFotoResponse _$CustomerUploadFotoResponseFromJson(
  Map<String, dynamic> json,
) => CustomerUploadFotoResponse(
  status: json['status'] as bool,
  message: json['message'] as String,
  data: CustomerUploadFotoData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CustomerUploadFotoResponseToJson(
  CustomerUploadFotoResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

CustomerUploadFotoData _$CustomerUploadFotoDataFromJson(
  Map<String, dynamic> json,
) => CustomerUploadFotoData(
  filename: json['filename'] as String,
  originalName: json['originalName'] as String,
  size: (json['size'] as num).toInt(),
  url: json['url'] as String,
  fullUrl: json['fullUrl'] as String,
  scheduleId: json['schedule_id'] as String,
  customerId: json['customer_id'] as String,
  latitude: json['latitude'] as String,
  longitude: json['longitude'] as String,
  address: json['address'] as String,
  statusVisit: (json['status_visit'] as num).toInt(),
  linkPathUpdated: json['link_path_updated'] as bool,
);

Map<String, dynamic> _$CustomerUploadFotoDataToJson(
  CustomerUploadFotoData instance,
) => <String, dynamic>{
  'filename': instance.filename,
  'originalName': instance.originalName,
  'size': instance.size,
  'url': instance.url,
  'fullUrl': instance.fullUrl,
  'schedule_id': instance.scheduleId,
  'customer_id': instance.customerId,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'address': instance.address,
  'status_visit': instance.statusVisit,
  'link_path_updated': instance.linkPathUpdated,
};
