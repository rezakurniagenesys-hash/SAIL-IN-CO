import 'package:json_annotation/json_annotation.dart';

part 'callsheet_summary_response.g.dart';

@JsonSerializable()
class CallsheetSummaryResponse {
  final bool? status;
  final String? message;
  final SummaryData? data;

  CallsheetSummaryResponse({this.status, this.message, this.data});

  factory CallsheetSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$CallsheetSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CallsheetSummaryResponseToJson(this);
}

@JsonSerializable()
class SummaryData {
  @JsonKey(name: "pending_tasks")
  final int? pendingTasks;

  @JsonKey(name: "completed_tasks")
  final int? completedTasks;

  @JsonKey(name: "total_tasks")
  final int? totalTasks;

  SummaryData({
    this.pendingTasks,
    this.completedTasks,
    this.totalTasks,
  });

  factory SummaryData.fromJson(Map<String, dynamic> json) =>
      _$SummaryDataFromJson(json);

  Map<String, dynamic> toJson() => _$SummaryDataToJson(this);
}
