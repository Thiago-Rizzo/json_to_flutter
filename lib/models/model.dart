import 'dart:convert';

import 'package:json_to_flutter/models/field.dart';

class Model {
  final String name;
  final List<Field> fields;

  Model({this.name = '', this.fields = const []});

  Model copyWith(Map<String, dynamic> data) {
    return Model(
      name: data['name'] ?? name,
      fields:
          data['fields'] != null && data['fields'] is List
              ? data['fields'].map<Field>((field) => Field.fromDynamic(field)).toList()
              : fields,
    );
  }

  factory Model.fromDynamic(dynamic source) =>
      source is Model ? source : Model().copyWith(dynamicToMap(source));

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
