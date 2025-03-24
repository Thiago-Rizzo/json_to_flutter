import 'dart:convert';
import 'dart:io';

import 'package:json_to_flutter/models/model.dart';
import 'package:json_to_flutter/stubs/model.stub.dart' as model_stub;
import 'package:json_to_flutter/stubs/super_model.stub.dart' as super_model_stub;

class Definitions {
  late final List<Model> models;
  late final String modelStub;
  late final String superModelStub;

  Definitions({models, modelStub, superModelStub}) {
    this.modelStub = modelStub ?? model_stub.getStub();
    this.superModelStub = superModelStub ?? super_model_stub.getStub();
    this.models = models ?? const [];
  }

  Definitions copyWith(Map<String, dynamic> data) {
    final superModelStub =
        data['superModelStub'] != null
            ? File(data['superModelStub']).readAsStringSync()
            : this.superModelStub;
    final modelStub = data['modelStub'] != null ? File(data['modelStub']).readAsStringSync() : this.modelStub;

    return Definitions(
      superModelStub: superModelStub,
      modelStub: modelStub,
      models:
          data['models'] != null && data['models'] is List
              ? data['models'].map<Model>((model) => Model.fromDynamic(model)).toList()
              : models,
    );
  }

  factory Definitions.fromDynamic(dynamic source) =>
      source is Definitions ? source : Definitions().copyWith(dynamicToMap(source));

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
