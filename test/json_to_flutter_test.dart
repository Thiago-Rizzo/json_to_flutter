import 'package:test/test.dart';
import 'package:json_to_flutter/json_to_flutter.dart' as json_to_flutter;

void main() {
  group('loadDefinitions function tests', () {
    test('test with valid file path', () async {
      // Arrange
      final filePath = 'test/models-definition.json';

      // Act
      final definitions = await json_to_flutter.loadDefinitions(filePath);

      // Assert
      expect(definitions, isMap);
      expect(definitions['models'], isList);
    });

    test('test with missing file', () async {
      // Arrange
      final filePath = 'missing/file.json';

      // Act and Assert
      expect(() async => await json_to_flutter.loadDefinitions(filePath), throwsException);
    });

    test('test with empty models definition', () async {
      // Arrange
      final filePath = 'test/empty-models-definition.json';

      // Act and Assert
      expect(() async => await json_to_flutter.loadDefinitions(filePath), throwsException);
    });

    test('test with empty fields definition', () async {
      // Arrange
      final filePath = 'test/empty-fields-models-definition.json';

      // Act and Assert
      expect(() async => await json_to_flutter.loadDefinitions(filePath), throwsException);
    });
  });

  group('makeModel function tests', () {
    test('test with valid model', () {
      // Arrange
      final model = {
        'name': 'TestModel',
        'fields': [
          {'name': 'id', 'type': 'int'},
          {'name': 'name', 'type': 'String'},
        ],
      };

      // Act
      final result = json_to_flutter.makeModel(model);

      // Assert
      expect(result, isTrue);
    });
  });

  group('getContent function tests', () {
    test('test with valid model', () {
      // Arrange
      final model = {
        'name': 'TestModel',
        'fields': [
          {'name': 'id', 'type': 'int'},
          {'name': 'name', 'type': 'String'},
        ],
      };

      // Act
      final content = json_to_flutter.getContent(model);

      // Assert
      expect(content, isA<String>());
      expect(content, contains('class TestModel'));
    });
  });

  group('getProperties function tests', () {
    test('test with valid model', () {
      // Arrange
      final model = {
        'name': 'TestModel',
        'fields': [
          {'name': 'id', 'type': 'int'},
          {'name': 'name', 'type': 'String'},
        ],
      };

      // Act
      final properties = json_to_flutter.getProperties(model);

      // Assert
      expect(properties, isA<String>());
      expect(properties, contains('final int id;'));
      expect(properties, contains('final String name;'));
    });
  });

  group('getParameters function tests', () {
    test('test with valid model', () {
      // Arrange
      final model = {
        'name': 'TestModel',
        'fields': [
          {'name': 'id', 'type': 'int'},
          {'name': 'name', 'type': 'String'},
        ],
      };

      // Act
      final parameters = json_to_flutter.getParameters(model);

      // Assert
      expect(parameters, isA<String>());
      expect(parameters, contains('this.id = 0,'));
      expect(parameters, contains('this.name = \'\','));
    });
  });

  group('getCopyWithParameters function tests', () {
    test('test with valid model', () {
      // Arrange
      final model = {
        'name': 'TestModel',
        'fields': [
          {'name': 'id', 'type': 'int'},
          {'name': 'name', 'type': 'String'},
        ],
      };

      // Act
      final copyWithParameters = json_to_flutter.getCopyWithParameters(model);

      // Assert
      expect(copyWithParameters, isA<String>());
      expect(copyWithParameters, contains('id: data[\'id\'] ?? id,'));
      expect(copyWithParameters, contains('name: data[\'name\'] ?? name,'));
    });
  });

  group('getToMapParameters function tests', () {
    test('test with valid model', () {
      // Arrange
      final model = {
        'name': 'TestModel',
        'fields': [
          {'name': 'id', 'type': 'int'},
          {'name': 'name', 'type': 'String'},
        ],
      };

      // Act
      final toMapParameters = json_to_flutter.getToMapParameters(model);

      // Assert
      expect(toMapParameters, isA<String>());
      expect(toMapParameters, contains('\': id,'));
      expect(toMapParameters, contains('\': name,'));
    });
  });

  group('camelCase function tests', () {
    test('test with valid string', () {
      // Arrange
      final input = 'hello_world';

      // Act
      final camelCaseString = json_to_flutter.camelCase(input);

      // Assert
      expect(camelCaseString, 'helloWorld');
    });
  });

  group('getDefaultValue function tests', () {
    test('test with valid property', () {
      // Arrange
      final property = {'type': 'int'};

      // Act
      final defaultValue = json_to_flutter.getDefaultValue(property);

      // Assert
      expect(defaultValue, '0');
    });
  });
}
