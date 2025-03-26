import 'dart:convert';

abstract class SuperModel {
  const SuperModel();

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
