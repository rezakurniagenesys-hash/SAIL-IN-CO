import 'package:json_annotation/json_annotation.dart';

part 'customer_item.g.dart';

@JsonSerializable()
class CustomerItem {
  @JsonKey(name: "no_acc6")
  final String? noAcc6;

  @JsonKey(name: "nm_acc6")
  final String? nmAcc6;

  final String? address;
  final String? phone;

  @JsonKey(name: "status_visit")
  final int? statusVisit;

  CustomerItem({
    this.noAcc6,
    this.nmAcc6,
    this.address,
    this.phone,
    this.statusVisit,
  });

  factory CustomerItem.fromJson(Map<String, dynamic> json) =>
      _$CustomerItemFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CustomerItemToJson(this);
}
