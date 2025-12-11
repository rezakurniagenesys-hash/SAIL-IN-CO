import 'package:json_annotation/json_annotation.dart';
import 'package:sail_in_co/data/models/general/general_inventory/general_inventory_response.dart';
import 'package:sail_in_co/data/models/general/general_uoms/general_uoms_response.dart';

part 'general_order_draft_item.g.dart';

@JsonSerializable(explicitToJson: true)
class GeneralOrderDraftItem {
  final InventoryItem inventory;
  final UOMItem uom;
  final int voidValue;
  final String uom_id;
  final String uom_id2;
  final int qty;
  final int qty2;
  final String defaultUomName;
  final int discount;
  final String notes;
  final String user_record;
  final int price;
  final int sub_total;
  final int grand_total;
  final int index;

  GeneralOrderDraftItem({
    required this.inventory,
    required this.uom,
    required this.qty,
    required this.defaultUomName,
    required this.discount,
    required this.notes,
    required this.user_record,
    required this.voidValue,
    required this.uom_id,
    required this.uom_id2,
    required this.qty2,
    required this.price,
    required this.sub_total,
    required this.grand_total,
    required this.index,
  });

  /// FROM JSON
  factory GeneralOrderDraftItem.fromJson(Map<String, dynamic> json) => _$GeneralOrderDraftItemFromJson(json);

  /// TO JSON
  Map<String, dynamic> toJson() => _$GeneralOrderDraftItemToJson(this);
}
