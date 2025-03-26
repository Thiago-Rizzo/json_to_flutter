import 'package:change_case/change_case.dart';
import 'package:json_to_flutter/models/module.dart';
import 'package:json_to_flutter/models/stub.dart';
import 'package:json_to_flutter/models/super_model.dart';

class Definitions extends SuperModel {
  late final List<Module> modules;
  late final String packageName;

  late final String superModelPath;
  late final String modelPath;
  late final String controllerPath;
  late final String servicePath;
  late final String httpClientPath;

  late final Stub stub;

  Definitions({
    modules,
    packageName,
    stub,
    superModelPath,
    modelPath,
    controllerPath,
    servicePath,
    httpClientPath,
  }) {
    this.packageName = packageName ?? '';

    this.stub = stub ?? Stub();

    this.superModelPath = superModelPath ?? 'lib/app/data/models/';
    this.httpClientPath = httpClientPath ?? 'lib/core/';
    this.modelPath = modelPath ?? 'lib/app/data/models/';
    this.servicePath = servicePath ?? 'lib/app/data/services/';
    this.controllerPath = controllerPath ?? 'lib/app/modules/{{model}}/';

    this.modules = modules ?? const [];
  }

  Definitions copyWith(Map<String, dynamic> data) {
    return Definitions(
      packageName: data['packageName'] ?? packageName,
      superModelPath: data['superModelPath'] ?? superModelPath,
      modelPath: data['modelPath'] ?? modelPath,
      controllerPath: data['controllerPath'] ?? controllerPath,
      servicePath: data['servicePath'] ?? servicePath,
      httpClientPath: data['httpClientPath'] ?? httpClientPath,
      stub: data['stubs'] != null ? Stub.fromDynamic(data['stubs']) : stub,
      modules:
          data['modules'] != null && data['modules'] is List
              ? data['modules'].map<Module>((model) => Module.fromDynamic(model)).toList()
              : modules,
    );
  }

  factory Definitions.fromDynamic(dynamic source) =>
      source is Definitions ? source : Definitions().copyWith(SuperModel.dynamicToMap(source));

  String getControllerPath(String moduleName) {
    final path = controllerPath.replaceAll('{{model}}', moduleName.toSnakeCase());

    return '${path}controller.dart';
  }

  String getServiceImportPath(String moduleName) {
    final path = servicePath.replaceAll('{{model}}', moduleName.toSnakeCase()).replaceFirst('lib/', '');

    return '$packageName/$path${moduleName.toSnakeCase()}_service.dart';
  }

  String getModelImportPath(String moduleName) {
    final path = modelPath.replaceAll('{{model}}', moduleName.toSnakeCase()).replaceFirst('lib/', '');

    return '$packageName/$path${moduleName.toSnakeCase()}.dart';
  }

  String getSuperModelImportPath() {
    final path = superModelPath.replaceAll('{{model}}', '').replaceFirst('lib/', '');

    return '$packageName/${path}model.dart';
  }

  String getHttpClientImportPath() {
    final path = httpClientPath.replaceAll('{{model}}', '').replaceFirst('lib/', '');

    return '$packageName/${path}http_client.dart';
  }
}
