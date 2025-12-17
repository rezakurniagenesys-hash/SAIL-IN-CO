import 'package:json_annotation/json_annotation.dart';

part 'default_setting_lock_stock_response.g.dart';

@JsonSerializable()
class DefaultSettingLockStockResponse {
  final bool status;
  final String message;
  final List<DefaultSettingLockStockData> data;

  DefaultSettingLockStockResponse({required this.status, required this.message, required this.data});

  factory DefaultSettingLockStockResponse.fromJson(Map<String, dynamic> json) => _$DefaultSettingLockStockResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultSettingLockStockResponseToJson(this);
}

@JsonSerializable()
class DefaultSettingLockStockData {
  @JsonKey(name: 'default_id')
  final String defaultId;

  final String value;

  @JsonKey(name: 'no_acc1')
  final String? noAcc1;

  @JsonKey(name: 'no_acc2')
  final String? noAcc2;

  @JsonKey(name: 'no_acc3')
  final String? noAcc3;

  @JsonKey(name: 'no_acc4')
  final String? noAcc4;

  @JsonKey(name: 'no_acc5')
  final String? noAcc5;

  @JsonKey(name: 'no_acc6')
  final String? noAcc6;

  @JsonKey(name: 'no_acc7')
  final String? noAcc7;

  DefaultSettingLockStockData({
    required this.defaultId,
    required this.value,
    this.noAcc1,
    this.noAcc2,
    this.noAcc3,
    this.noAcc4,
    this.noAcc5,
    this.noAcc6,
    this.noAcc7,
  });

  factory DefaultSettingLockStockData.fromJson(Map<String, dynamic> json) => _$DefaultSettingLockStockDataFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultSettingLockStockDataToJson(this);
}
