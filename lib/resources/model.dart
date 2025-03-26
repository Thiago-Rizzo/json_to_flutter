import 'package:change_case/change_case.dart';
import 'package:json_to_flutter/models/definitions.dart';
import 'package:json_to_flutter/models/field.dart';
import 'package:json_to_flutter/models/module.dart';
import 'package:json_to_flutter/utils/utils.dart';

class ModelResource {
  final Definitions definitions;

  const ModelResource(this.definitions);

  Future<void> generate() async {
    // generate super model
    await writeToFile('${definitions.superModelPath}model.dart', definitions.superModelStub);

    // generate models
    for (var module in definitions.modules) {
      await writeToFile('${definitions.modelPath}${module.name.toSnakeCase()}.dart', _getContent(module));
    }
  }

  String _getContent(Module module) {
    String model = definitions.modelStub;

    model = model.replaceAll('{{imports}}', _getImports(module));
    model = model.replaceAll('{{className}}', module.name.toPascalCase());
    model = model.replaceAll('{{properties}}', _getProperties(module));
    model = model.replaceAll('{{parameters}}', _getParameters(module));
    model = model.replaceAll('{{copyWithParameters}}', _getCopyWithParameters(module));
    model = model.replaceAll('{{toMapParameters}}', _getToMapParameters(module));

    return model;
  }

  String _getImports(Module module) {
    String imports = '';

    imports += 'import \'package:${definitions.getSuperModelImportPath()}\';';

    return imports;
  }

  String _getProperties(Module module) {
    return module.fields.map((field) => 'final ${field.type} ${field.name.toCamelCase()};').join('\n  ');
  }

  String _getParameters(Module module) {
    return module.fields
        .map((field) => 'this.${field.name.toCamelCase()} = ${_getDefaultValue(field)},')
        .join('\n    ');
  }

  String _getCopyWithParameters(Module module) {
    return module.fields
        .map(
          (field) => '${field.name.toCamelCase()}: data[\'${field.name}\'] ?? ${field.name.toCamelCase()},',
        )
        .join('\n      ');
  }

  String _getToMapParameters(Module module) {
    return module.fields.map((field) => '\'${field.name}\': ${field.name.toCamelCase()},').join('\n      ');
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
