import 'package:change_case/change_case.dart';
import 'package:json_to_flutter/models/definitions.dart';
import 'package:json_to_flutter/models/module.dart';
import 'package:json_to_flutter/utils/utils.dart';

class ServiceResource {
  final Definitions definitions;

  const ServiceResource(this.definitions);

  Future<void> generate() async {
    await writeToFile('${definitions.httpClientPath}http_client.dart', definitions.httpClientStub);

    for (var module in definitions.modules) {
      await writeToFile(
        '${definitions.servicePath}${module.name.toSnakeCase()}_service.dart',
        _getContent(module),
      );
    }
  }

  String _getContent(Module module) {
    String service = definitions.serviceStub;

    service = service.replaceAll('{{imports}}', _getImports(module.name.toSnakeCase()));
    service = service.replaceAll('{{className}}', '${module.name.toPascalCase()}Service');
    service = service.replaceAll('{{model}}', module.name.toPascalCase());
    service = service.replaceAll('{{endpointResource}}', module.name.toSnakeCase());

    return service;
  }

  String _getImports(String model) {
    String imports = '';

    imports += 'import \'package:${definitions.getModelImportPath(model)}\';\n';
    imports += 'import \'package:${definitions.getHttpClientImportPath()}\';';

    return imports;
  }
}
