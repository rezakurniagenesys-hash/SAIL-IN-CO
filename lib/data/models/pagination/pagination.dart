import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable()
class Pagination {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPages;
  final bool? hasNext;
  final bool? hasPrev;

  Pagination({
    this.page,
    this.limit,
    this.total,
    this.totalPages,
    this.hasNext,
    this.hasPrev,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PaginationToJson(this);
}
