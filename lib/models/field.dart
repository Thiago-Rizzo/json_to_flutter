import 'package:json_to_flutter/models/super_model.dart';

class Field extends SuperModel {
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
      source is Field ? source : Field().copyWith(SuperModel.dynamicToMap(source));
}
