// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'callsheet_summary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CallsheetSummaryResponse _$CallsheetSummaryResponseFromJson(
  Map<String, dynamic> json,
) => CallsheetSummaryResponse(
  status: json['status'] as bool?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : SummaryData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CallsheetSummaryResponseToJson(
  CallsheetSummaryResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

SummaryData _$SummaryDataFromJson(Map<String, dynamic> json) => SummaryData(
  pendingTasks: (json['pending_tasks'] as num?)?.toInt(),
  completedTasks: (json['completed_tasks'] as num?)?.toInt(),
  totalTasks: (json['total_tasks'] as num?)?.toInt(),
);

Map<String, dynamic> _$SummaryDataToJson(SummaryData instance) =>
    <String, dynamic>{
      'pending_tasks': instance.pendingTasks,
      'completed_tasks': instance.completedTasks,
      'total_tasks': instance.totalTasks,
    };
