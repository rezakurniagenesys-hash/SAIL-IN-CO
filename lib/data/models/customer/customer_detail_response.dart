import 'package:json_annotation/json_annotation.dart';

part 'customer_detail_response.g.dart';

@JsonSerializable()
class CustomerDetailResponse {
  final bool? status;
  final String? message;
  final CustomerDetailData? data;

  CustomerDetailResponse({this.status, this.message, this.data});

  factory CustomerDetailResponse.fromJson(Map<String, dynamic> json) => _$CustomerDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDetailResponseToJson(this);
}

@JsonSerializable()
class CustomerDetailData {
  final CustomerModel? customer;

  CustomerDetailData({this.customer});

  factory CustomerDetailData.fromJson(Map<String, dynamic> json) => _$CustomerDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDetailDataToJson(this);
}

@JsonSerializable()
class CustomerModel {
  @JsonKey(name: "no_acc6")
  final String? noAcc6;

  @JsonKey(name: "nm_acc6")
  final String? name;

  final String? address;
  final String? phone;
  final String? province;
  final String? city;
  final String? district;

  @JsonKey(name: "sub_district")
  final String? subDistrict;

  final String? nik;

  @JsonKey(name: "credit_limit")
  final String? creditLimit;

  @JsonKey(name: "default_payment")
  final String? defaultPayment;

  @JsonKey(name: "area_id")
  final String? areaId;

  @JsonKey(name: "type_customer")
  final String? typeCustomer;

  @JsonKey(name: "area_name")
  final String? areaName;

  @JsonKey(name: "status_visit")
  final int? statusVisit;

  @JsonKey(name: "link_path")
  final String? linkPath;

  final String? latitude;
  final String? longitude;

  @JsonKey(name: "visit_address")
  final String? visitAddress;

  @JsonKey(name: "visit_date")
  final DateTime? visitDate;

  final String? reason;

  @JsonKey(name: "visit_notes")
  final String? visitNotes;

  CustomerModel({
    this.noAcc6,
    this.name,
    this.address,
    this.phone,
    this.province,
    this.city,
    this.district,
    this.subDistrict,
    this.nik,
    this.creditLimit,
    this.defaultPayment,
    this.areaId,
    this.typeCustomer,
    this.areaName,
    this.statusVisit,
    this.linkPath,
    this.latitude,
    this.longitude,
    this.visitAddress,
    this.visitDate,
    this.reason,
    this.visitNotes,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}
