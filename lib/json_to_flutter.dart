import 'dart:io';

import 'package:json_to_flutter/models/definitions.dart';

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

    if (definitions.modules.isEmpty) {
      throw Exception('Arquivo Invalido, Arquivo não contém models.');
    }

    for (var module in definitions.modules) {
      if (module.name.isEmpty) {
        throw Exception('Arquivo Invalido, models não contém name.');
      }

      if (module.fields.isEmpty) {
        throw Exception('Arquivo Invalido, models não contém fields.');
      }

      for (var field in module.fields) {
        if (field.name.isEmpty) {
          throw Exception('Arquivo Invalido, fields nao contém name.');
        }

        if (field.type.isEmpty) {
          throw Exception('Arquivo Invalido, fields nao contém type.');
        }
      }
    }
  }
}
