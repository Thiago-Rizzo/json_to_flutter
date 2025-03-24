import 'dart:io';

import 'package:json_to_flutter/models/definitions.dart';
import 'package:json_to_flutter/models/field.dart';
import 'package:json_to_flutter/models/model.dart';

class JsonToFlutter {
  late Definitions definitions;

  JsonToFlutter(filePath) {
    _loadDefinitions(filePath);
  }

  void _loadDefinitions(filePath) {
    final file = File(filePath);

    if (!file.existsSync()) {
      throw Exception('Arquivo não encontrado.');
    }

    definitions = Definitions.fromDynamic(file.readAsStringSync());

    if (definitions.superModelStub.isEmpty) {
      throw Exception('Arquivo Invalido, Arquivo não contém superModelStub.');
    }

    if (definitions.modelStub.isEmpty) {
      throw Exception('Arquivo Invalido, Arquivo não contém modelStub.');
    }

    if (definitions.models.isEmpty) {
      throw Exception('Arquivo Invalido, Arquivo não contém models.');
    }

    for (var model in definitions.models) {
      if (model.name.isEmpty) {
        throw Exception('Arquivo Invalido, models não contém name.');
      }

      if (model.fields.isEmpty) {
        throw Exception('Arquivo Invalido, models não contém fields.');
      }

      for (var field in model.fields) {
        if (field.name.isEmpty) {
          throw Exception('Arquivo Invalido, fields nao contém name.');
        }

        if (field.type.isEmpty) {
          throw Exception('Arquivo Invalido, fields nao contém type.');
        }
      }
    }
  }

  JsonToFlutter makeModels() {
    // generate super model
    File('model.dart').writeAsString(definitions.superModelStub);

    // generate models
    for (var model in definitions.models) {
      final modelName = model.name.toLowerCase();

      final data = {
        'className': model.name,
        'properties': _getProperties(model),
        'parameters': _getParameters(model),
        'copyWithParameters': _getCopyWithParameters(model),
        'toMapParameters': _getToMapParameters(model),
      };

      File('$modelName.dart').writeAsString(_getContent(data));
    }

    return this;
  }

  String _getContent(Map<String, dynamic> data) {
    String model = definitions.modelStub;

    model = model.replaceAll('{{className}}', data['className']);
    model = model.replaceAll('{{properties}}', data['properties']);
    model = model.replaceAll('{{parameters}}', data['parameters']);
    model = model.replaceAll('{{copyWithParameters}}', data['copyWithParameters']);
    model = model.replaceAll('{{toMapParameters}}', data['toMapParameters']);

    return model;
  }

  String _getProperties(Model model) {
    return model.fields.map((field) => 'final ${field.type} ${_camelCase(field.name)};').join('\n  ');
  }

  String _getParameters(Model model) {
    return model.fields
        .map((field) => 'this.${_camelCase(field.name)} = ${_getDefaultValue(field)},')
        .join('\n    ');
  }

  String _getCopyWithParameters(Model model) {
    return model.fields
        .map((field) => '${_camelCase(field.name)}: data[\'${field.name}\'] ?? ${_camelCase(field.name)},')
        .join('\n      ');
  }

  String _getToMapParameters(Model model) {
    return model.fields.map((field) => '\'${field.name}\': ${_camelCase(field.name)},').join('\n      ');
  }

  String _camelCase(String name) {
    return name.split('_')[0] +
        name.split('_').skip(1).map((word) => word[0].toUpperCase() + word.substring(1)).join('');
  }

  String _getDefaultValue(Field field) {
    if (field.defaultValue.isNotEmpty) {
      return field.defaultValue;
    }

    final type = field.type.toString().toLowerCase();

    if (type == 'bool') {
      return 'false';
    }

    if (type == 'int') {
      return '0';
    }

    if (type == 'float' || type == 'double') {
      return '0.0';
    }

    if (type == 'string') {
      return '\'\'';
    }

    if (type == 'datetime') {
      return 'DateTime.now()';
    }

    return 'null';
  }
}
