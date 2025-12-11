import 'package:json_annotation/json_annotation.dart';

part 'general_inventory_request.g.dart';

@JsonSerializable()
class GeneralInventoryRequest {
  final int? page;
  final int? limit;
  final String? warehouseId;
  final String? date;
  final String? search;

  GeneralInventoryRequest({this.page, this.limit, this.warehouseId, this.date, this.search});

  /// Untuk query params
  Map<String, dynamic> toQuery() {
    final Map<String, dynamic> query = {};

    if (page != null) query['page'] = page;
    if (limit != null) query['limit'] = limit;
    if (warehouseId != null && warehouseId!.isNotEmpty) query['warehouse_id'] = warehouseId;
    if (date != null && date!.isNotEmpty) query['date'] = date;
    if (search != null && search!.isNotEmpty) query['search'] = search;

    return query;
  }

  factory GeneralInventoryRequest.fromJson(Map<String, dynamic> json) => _$GeneralInventoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralInventoryRequestToJson(this);
}
