// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryRequest _$SummaryRequestFromJson(Map<String, dynamic> json) =>
    SummaryRequest(
      date: json['date'] as String?,
      salesId: json['sales_id'] as String?,
    );

Map<String, dynamic> _$SummaryRequestToJson(SummaryRequest instance) =>
    <String, dynamic>{'date': ?instance.date, 'sales_id': ?instance.salesId};
