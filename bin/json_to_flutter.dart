import 'package:json_to_flutter/json_to_flutter.dart';

void main(List<String> arguments) async {
  var filePath = arguments.firstOrNull ?? 'models-definition.json';

  JsonToFlutter(filePath).makeModels();
}
