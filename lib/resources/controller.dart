import 'package:change_case/change_case.dart';
import 'package:json_to_flutter/models/definitions.dart';
import 'package:json_to_flutter/models/module.dart';
import 'package:json_to_flutter/utils/utils.dart';

class ControllerResource {
  final Definitions definitions;

  const ControllerResource(this.definitions);

  Future<void> generate() async {
    for (var module in definitions.modules) {
      await writeToFile(definitions.getControllerPath(module.name.toSnakeCase()), _getContent(module));
    }
  }

  String _getContent(Module module) {
    String controller = definitions.stub.controllerStub;

    controller = controller.replaceAll('{{imports}}', _getImports(module.name.toSnakeCase()));
    controller = controller.replaceAll('{{className}}', '${module.name.toPascalCase()}Controller');
    controller = controller.replaceAll('{{model}}', module.name.toPascalCase());
    controller = controller.replaceAll('{{service}}', '${module.name.toPascalCase()}Service');

    return controller;
  }

  String _getImports(String model) {
    String imports = '';

    imports += 'import \'package:${definitions.getServiceImportPath(model)}\';\n';
    imports += 'import \'package:${definitions.getModelImportPath(model)}\';';

    return imports;
  }
}
