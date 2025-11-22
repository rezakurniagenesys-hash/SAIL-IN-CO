import 'package:json_annotation/json_annotation.dart';

part 'auth_response_model.g.dart';

@JsonSerializable()
class AuthResponseModel {
  final bool? result;
  final String? message;
  final Data? data;

  AuthResponseModel({this.result, this.message, this.data});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) => _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);
}

@JsonSerializable()
class Data {
  final String? token;

  @JsonKey(name: "refresh_token")
  final String? refreshToken;

  @JsonKey(name: "data")
  final UserInfo? userInfo;

  Data({this.token, this.refreshToken, this.userInfo});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class UserInfo {
  final int? exp;
  final String? iss;
  final String? sub;
  final String? username;

  @JsonKey(name: "user_id")
  final String? userId;

  @JsonKey(name: "source_id")
  final String? sourceId;

  final int? type;

  @JsonKey(name: "user_type")
  final String? userType;

  UserInfo({this.exp, this.iss, this.sub, this.username, this.userId, this.sourceId, this.type, this.userType});

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
