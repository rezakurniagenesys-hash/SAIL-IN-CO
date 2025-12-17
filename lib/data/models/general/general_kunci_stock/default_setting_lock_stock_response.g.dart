// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'default_setting_lock_stock_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DefaultSettingLockStockResponse _$DefaultSettingLockStockResponseFromJson(
  Map<String, dynamic> json,
) => DefaultSettingLockStockResponse(
  status: json['status'] as bool,
  message: json['message'] as String,
  data: (json['data'] as List<dynamic>)
      .map(
        (e) => DefaultSettingLockStockData.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$DefaultSettingLockStockResponseToJson(
  DefaultSettingLockStockResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

DefaultSettingLockStockData _$DefaultSettingLockStockDataFromJson(
  Map<String, dynamic> json,
) => DefaultSettingLockStockData(
  defaultId: json['default_id'] as String,
  value: json['value'] as String,
  noAcc1: json['no_acc1'] as String?,
  noAcc2: json['no_acc2'] as String?,
  noAcc3: json['no_acc3'] as String?,
  noAcc4: json['no_acc4'] as String?,
  noAcc5: json['no_acc5'] as String?,
  noAcc6: json['no_acc6'] as String?,
  noAcc7: json['no_acc7'] as String?,
);

Map<String, dynamic> _$DefaultSettingLockStockDataToJson(
  DefaultSettingLockStockData instance,
) => <String, dynamic>{
  'default_id': instance.defaultId,
  'value': instance.value,
  'no_acc1': instance.noAcc1,
  'no_acc2': instance.noAcc2,
  'no_acc3': instance.noAcc3,
  'no_acc4': instance.noAcc4,
  'no_acc5': instance.noAcc5,
  'no_acc6': instance.noAcc6,
  'no_acc7': instance.noAcc7,
};
