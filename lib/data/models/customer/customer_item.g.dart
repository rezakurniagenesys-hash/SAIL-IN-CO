// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerItem _$CustomerItemFromJson(Map<String, dynamic> json) => CustomerItem(
  hasVisit: (json['has_visit'] as num?)?.toInt(),
  scheduleDate: json['schedule_date'] as String?,
  noAcc6: json['no_acc6'] as String?,
  nmAcc6: json['nm_acc6'] as String?,
  address: json['address'] as String?,
  phone: json['phone'] as String?,
  statusVisit: (json['status_visit'] as num?)?.toInt(),
  scheduleId: json['schedule_id'] as String?,
);

Map<String, dynamic> _$CustomerItemToJson(CustomerItem instance) =>
    <String, dynamic>{
      'no_acc6': instance.noAcc6,
      'nm_acc6': instance.nmAcc6,
      'address': instance.address,
      'phone': instance.phone,
      'status_visit': instance.statusVisit,
      'has_visit': instance.hasVisit,
      'schedule_id': instance.scheduleId,
      'schedule_date': instance.scheduleDate,
    };
