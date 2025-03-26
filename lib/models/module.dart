import 'package:json_to_flutter/models/field.dart';
import 'package:json_to_flutter/models/super_model.dart';

class Module extends SuperModel {
  final String name;
  final List<Field> fields;

  const Module({this.name = '', this.fields = const []});

  Module copyWith(Map<String, dynamic> data) {
    return Module(
      name: data['name'] ?? name,
      fields:
          data['fields'] != null && data['fields'] is List
              ? List<Field>.from(data['fields'].map<Field>((field) => Field.fromDynamic(field)))
              : fields,
    );
  }

  factory Module.fromDynamic(dynamic source) =>
      source is Module ? source : Module().copyWith(SuperModel.dynamicToMap(source));
}
