import 'package:json_annotation/json_annotation.dart';

class StringToStringConverter implements JsonConverter<String?, dynamic> {
  const StringToStringConverter();

  @override
  String? fromJson(dynamic json) {
    if (json == null) return null;
    return json.toString();
  }

  @override
  dynamic toJson(String? object) => object;
}
