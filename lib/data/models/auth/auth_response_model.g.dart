// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponseModel _$AuthResponseModelFromJson(Map<String, dynamic> json) =>
    AuthResponseModel(
      result: json['result'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseModelToJson(AuthResponseModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  token: json['token'] as String?,
  refreshToken: json['refresh_token'] as String?,
  userInfo: json['data'] == null
      ? null
      : UserInfo.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'token': instance.token,
  'refresh_token': instance.refreshToken,
  'data': instance.userInfo,
};

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
  exp: (json['exp'] as num?)?.toInt(),
  iss: json['iss'] as String?,
  sub: json['sub'] as String?,
  username: json['username'] as String?,
  userId: json['user_id'] as String?,
  sourceId: json['source_id'] as String?,
  type: (json['type'] as num?)?.toInt(),
  userType: json['user_type'] as String?,
);

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
  'exp': instance.exp,
  'iss': instance.iss,
  'sub': instance.sub,
  'username': instance.username,
  'user_id': instance.userId,
  'source_id': instance.sourceId,
  'type': instance.type,
  'user_type': instance.userType,
};
