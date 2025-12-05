import 'package:json_annotation/json_annotation.dart';

part 'customer_upload_foto_request.g.dart';

@JsonSerializable()
class CustomerUploadFotoRequest {
  final String latitude;
  final String longitude;
  final String address;

  @JsonKey(name: 'status_visit')
  final int statusVisit;

  @JsonKey(name: 'user_modified')
  final String userModified;

  CustomerUploadFotoRequest({
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.statusVisit,
    required this.userModified,
  });

  factory CustomerUploadFotoRequest.fromJson(Map<String, dynamic> json) =>
      _$CustomerUploadFotoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerUploadFotoRequestToJson(this);
}
