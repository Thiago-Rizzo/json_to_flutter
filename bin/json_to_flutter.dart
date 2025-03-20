import 'package:json_to_flutter/json_to_flutter.dart' as json_to_flutter;

void main(List<String> arguments) async {
  var filePath = arguments.firstOrNull ?? 'models-definition.json';

  final definitions = await json_to_flutter.loadDefinitions(filePath);

  for (var model in definitions['models']) {
    json_to_flutter.makeModel(model);
  }
}
