import 'dart:convert';

class Field {
  final String name;
  final String type;
  final String defaultValue;

  const Field({this.name = '', this.type = '', this.defaultValue = ''});

  Field copyWith(Map<String, dynamic> data) {
    return Field(
      name: data['name'] ?? name,
      type: data['type'] ?? type,
      defaultValue: data['default'] ?? defaultValue,
    );
  }

  factory Field.fromDynamic(dynamic source) =>
      source is Field ? source : Field().copyWith(dynamicToMap(source));

  static Map<String, dynamic> dynamicToMap(dynamic source) {
    try {
      if (source is String) {
        source = jsonDecode(source);
      }
    } catch (e) {
      return <String, dynamic>{};
    }

    if (source is Map) {
      return source.cast<String, dynamic>();
    }

    if (source == null) {
      return <String, dynamic>{};
    }

    return dynamicToMap(source);
  }
}
