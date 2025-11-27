import 'package:json_annotation/json_annotation.dart';

part 'summary_request.g.dart';

@JsonSerializable(includeIfNull: false)
class SummaryRequest {
  final String? date;

  @JsonKey(name: "sales_id")
  final String? salesId;

  SummaryRequest({this.date, this.salesId});

  /// Convert to query params
  Map<String, dynamic> toQuery() => {if (date != null && date!.isNotEmpty) 'date': date, if (salesId != null && salesId!.isNotEmpty) 'sales_id': salesId};

  factory SummaryRequest.fromJson(Map<String, dynamic> json) => _$SummaryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SummaryRequestToJson(this);
}
