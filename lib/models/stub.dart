import 'package:json_to_flutter/models/super_model.dart';
import 'package:json_to_flutter/stubs/model.stub.dart' as model_stub;
import 'package:json_to_flutter/stubs/super_model.stub.dart' as super_model_stub;
import 'package:json_to_flutter/stubs/controller.stub.dart' as controller_stub;
import 'package:json_to_flutter/stubs/service.stub.dart' as service_stub;
import 'package:json_to_flutter/stubs/http_client.stub.dart' as http_client_stub;
import 'package:json_to_flutter/utils/utils.dart';

class Stub extends SuperModel {
  late final String superModelStub;
  late final String modelStub;
  late final String controllerStub;
  late final String serviceStub;
  late final String httpClientStub;

  Stub({superModelStub, modelStub, controllerStub, serviceStub, httpClientStub}) {
    this.superModelStub = superModelStub ?? super_model_stub.getStub();
    this.modelStub = modelStub ?? model_stub.getStub();
    this.controllerStub = controllerStub ?? controller_stub.getStub();
    this.serviceStub = serviceStub ?? service_stub.getStub();
    this.httpClientStub = httpClientStub ?? http_client_stub.getStub();
  }

  Stub copyWith(Map<String, dynamic> data) {
    final superModelStub = readFile(data['superModel'], this.superModelStub);
    final modelStub = readFile(data['model'], this.modelStub);
    final serviceStub = readFile(data['service'], this.serviceStub);
    final controllerStub = readFile(data['controller'], this.controllerStub);
    final httpClientStub = readFile(data['httpClient'], this.httpClientStub);

    return Stub(
      superModelStub: superModelStub,
      modelStub: modelStub,
      controllerStub: controllerStub,
      serviceStub: serviceStub,
      httpClientStub: httpClientStub,
    );
  }

  factory Stub.fromDynamic(dynamic source) =>
      source is Stub ? source : Stub().copyWith(SuperModel.dynamicToMap(source));
}
