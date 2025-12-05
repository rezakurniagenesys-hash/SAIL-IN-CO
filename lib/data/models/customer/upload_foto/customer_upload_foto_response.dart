import 'package:json_annotation/json_annotation.dart';

part 'customer_upload_foto_response.g.dart';

@JsonSerializable()
class CustomerUploadFotoResponse {
  final bool status;
  final String message;
  final CustomerUploadFotoData data;

  CustomerUploadFotoResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CustomerUploadFotoResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerUploadFotoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerUploadFotoResponseToJson(this);
}

@JsonSerializable()
class CustomerUploadFotoData {
  final String filename;

  @JsonKey(name: 'originalName')
  final String originalName;

  final int size;
  final String url;
  final String fullUrl;

  @JsonKey(name: 'schedule_id')
  final String scheduleId;

  @JsonKey(name: 'customer_id')
  final String customerId;

  final String latitude;
  final String longitude;
  final String address;

  @JsonKey(name: 'status_visit')
  final int statusVisit;

  @JsonKey(name: 'link_path_updated')
  final bool linkPathUpdated;

  CustomerUploadFotoData({
    required this.filename,
    required this.originalName,
    required this.size,
    required this.url,
    required this.fullUrl,
    required this.scheduleId,
    required this.customerId,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.statusVisit,
    required this.linkPathUpdated,
  });

  factory CustomerUploadFotoData.fromJson(Map<String, dynamic> json) =>
      _$CustomerUploadFotoDataFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerUploadFotoDataToJson(this);
}
