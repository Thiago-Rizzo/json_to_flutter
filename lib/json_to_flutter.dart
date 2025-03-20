import 'dart:io';
import 'dart:convert';

Future<Map<String, dynamic>> loadDefinitions(filePath) async {
  final file = File(filePath);

  if (await file.exists()) {
    String jsonString = await file.readAsString();

    final definitions = jsonDecode(jsonString).cast<String, dynamic>();

    if (definitions.containsKey('models') && definitions['models'] is List) {
      if (definitions['models'].isEmpty) {
        throw Exception('Arquivo Invalido, Arquivo não contém models.');
      }

      for (var model in definitions['models']) {
        if (model is Map &&
            model.containsKey('name') &&
            model.containsKey('fields') &&
            model['fields'] is List) {
          if (model['fields'].isEmpty) {
            throw Exception('Arquivo Invalido, models não contém fields.');
          }

          return definitions;
        }
      }
    }

    throw Exception('Arquivo não válido.');
  } else {
    throw Exception('Arquivo não encontrado.');
  }
}

bool makeModel(Map<String, dynamic> model) {
  final modelName = model['name'].toLowerCase();
  // final file = File('lib/app/data/models/${modelName}.dart');
  final file = File('$modelName.dart');

  file.writeAsString(getContent(model));
  file.create();

  return true;
}

String getContent(Map<String, dynamic> model) {
  return '''import 'dart:convert';

class ${model['name']} {
  ${getProperties(model)}
  
  const ${model['name']}({
    ${getParameters(model)}
  });

  ${model['name']} copyWith(Map<String, dynamic> data) {
    return ${model['name']}(
      ${getCopyWithParameters(model)}
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ${getToMapParameters(model)}
    };
  }

  factory ${model['name']}.fromDynamic(dynamic source) =>
      source is ${model['name']} ? source : ${model['name']}().copyWith(dynamicToMap(source));

  String toJson() => jsonEncode(toMap());

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
''';
}

String getProperties(Map<String, dynamic> model) {
  return model['fields']
      .map((property) => 'final ${property['type']} ${camelCase(property['name'])};')
      .join('\n  ');
}

String getParameters(Map<String, dynamic> model) {
  return model['fields']
      .map((property) => 'this.${camelCase(property['name'])} = ${getDefaultValue(property)},')
      .join('\n    ');
}

String getCopyWithParameters(Map<String, dynamic> model) {
  return model['fields']
      .map(
        (property) =>
            '${camelCase(property['name'])}: data[\'${property['name']}\'] ?? ${camelCase(property['name'])},',
      )
      .join('\n      ');
}

String getToMapParameters(Map<String, dynamic> model) {
  return model['fields']
      .map((property) => '\'${property['name']}\': ${camelCase(property['name'])},')
      .join('\n      ');
}

String camelCase(String name) {
  return name.split('_')[0] +
      name.split('_').skip(1).map((word) => word[0].toUpperCase() + word.substring(1)).join('');
}

String getDefaultValue(Map<String, dynamic> property) {
  if (property.containsKey('default')) {
    return property['default'];
  }

  final type = property['type'].toString().toLowerCase();

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
