String getStub() => '''
import 'dart:convert';
import 'model.dart';

class {{className}} extends Model {
  {{properties}}
  
  const {{className}}({
    {{parameters}}
  });

  {{className}} copyWith(Map<String, dynamic> data) {
    return {{className}}(
      {{copyWithParameters}}
    );
  }

  Map<String, dynamic> toMap() {
    return {
      {{toMapParameters}}
    };
  }

  factory {{className}}.fromDynamic(dynamic source) => 
    source is {{className}} ? source : {{className}}().copyWith(Model.dynamicToMap(source));

  String toJson() => jsonEncode(toMap());
}
''';
