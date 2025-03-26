import 'package:json_to_flutter/json_to_flutter.dart';
import 'package:json_to_flutter/resources/model.dart';
import 'package:json_to_flutter/resources/controller.dart';
import 'package:json_to_flutter/resources/service.dart';

void main(List<String> arguments) async {
  var filePath = /*arguments.firstOrNull ?? */ 'modules-definition.json';

  final jsonToFlutter = JsonToFlutter(filePath);

  // if (!arguments.contains('generate')) {
  ModelResource(jsonToFlutter.definitions).generate();
  ServiceResource(jsonToFlutter.definitions).generate();
  ControllerResource(jsonToFlutter.definitions).generate();
  // }
}
