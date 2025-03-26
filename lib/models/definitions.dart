import 'package:change_case/change_case.dart';
import 'package:json_to_flutter/models/module.dart';
import 'package:json_to_flutter/models/super_model.dart';
import 'package:json_to_flutter/stubs/model.stub.dart' as model_stub;
import 'package:json_to_flutter/stubs/super_model.stub.dart' as super_model_stub;
import 'package:json_to_flutter/stubs/controller.stub.dart' as controller_stub;
import 'package:json_to_flutter/stubs/service.stub.dart' as service_stub;
import 'package:json_to_flutter/stubs/http_client.stub.dart' as http_client_stub;
import 'package:json_to_flutter/utils/utils.dart';

class Definitions extends SuperModel {
  late final List<Module> modules;
  late final String packageName;
  late final String superModelStub;
  late final String modelStub;
  late final String controllerStub;
  late final String serviceStub;
  late final String httpClientStub;

  late final String superModelPath;
  late final String modelPath;
  late final String controllerPath;
  late final String servicePath;
  late final String httpClientPath;

  Definitions({
    modules,
    packageName,
    superModelStub,
    modelStub,
    controllerStub,
    serviceStub,
    httpClientStub,
    superModelPath,
    modelPath,
    controllerPath,
    servicePath,
    httpClientPath,
  }) {
    this.packageName = packageName ?? '';

    this.superModelStub = superModelStub ?? super_model_stub.getStub();
    this.modelStub = modelStub ?? model_stub.getStub();
    this.controllerStub = controllerStub ?? controller_stub.getStub();
    this.serviceStub = serviceStub ?? service_stub.getStub();
    this.httpClientStub = httpClientStub ?? http_client_stub.getStub();

    this.superModelPath = superModelPath ?? 'lib/app/data/models/';
    this.httpClientPath = httpClientPath ?? 'lib/core/';
    this.modelPath = modelPath ?? 'lib/app/data/models/';
    this.servicePath = servicePath ?? 'lib/app/data/services/';
    this.controllerPath = controllerPath ?? 'lib/app/modules/{{model}}/';

    this.modules = modules ?? const [];
  }

  Definitions copyWith(Map<String, dynamic> data) {
    final superModelStub = readFile(data['superModelStub'], this.superModelStub);
    final modelStub = readFile(data['modelStub'], this.modelStub);
    final serviceStub = readFile(data['serviceStub'], this.serviceStub);
    final controllerStub = readFile(data['controllerStub'], this.controllerStub);
    final httpClientStub = readFile(data['httpClientStub'], this.httpClientStub);

    return Definitions(
      packageName: data['packageName'] ?? packageName,
      superModelStub: superModelStub,
      modelStub: modelStub,
      controllerStub: controllerStub,
      serviceStub: serviceStub,
      httpClientStub: httpClientStub,
      superModelPath: data['superModelPath'] ?? superModelPath,
      modelPath: data['modelPath'] ?? modelPath,
      controllerPath: data['controllerPath'] ?? controllerPath,
      servicePath: data['servicePath'] ?? servicePath,
      httpClientPath: data['httpClientPath'] ?? httpClientPath,
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
