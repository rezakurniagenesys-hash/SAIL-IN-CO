import 'package:json_annotation/json_annotation.dart';

part 'general_uoms_response.g.dart';

@JsonSerializable()
class UOMItem {
  @JsonKey(name: 'inventory_id')
  final String inventoryId;

  @JsonKey(name: 'uom_id')
  final String uomId;

  @JsonKey(name: 'uom_name')
  final String uomName;

  final String value;

  @JsonKey(name: 'default')
  final int isDefault;

  final String notes;

  UOMItem({required this.inventoryId, required this.uomId, required this.uomName, required this.value, required this.isDefault, required this.notes});

  factory UOMItem.fromJson(Map<String, dynamic> json) => _$UOMItemFromJson(json);

  Map<String, dynamic> toJson() => _$UOMItemToJson(this);
}
