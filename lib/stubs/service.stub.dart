String getStub() => '''
{{imports}}

class {{className}} {
  const {{className}}();

  Future<List<{{model}}>> getAll() {
    return Client().dio.get('{{endpointResource}}').then((response) {
      final data = response.data['data'];

      if (data is List) {
        return List<{{model}}>.from(data.map((model) => {{model}}.fromDynamic(model)));
      }
      
      return [];
    });
  }

  Future<{{model}}> getById(int id) {
    return Client().dio.get('{{endpointResource}}/\$id').then((response) => {{model}}.fromDynamic(response.data['data']));
  }

  Future<{{model}}> create({{model}} data) {
    return Client().dio.post('{{endpointResource}}', data: data.toMap()).then((response) => {{model}}.fromDynamic(response.data['data']));
  }

  Future<{{model}}> update({{model}} data) {
    return Client().dio.put('{{endpointResource}}/\${data.id}', data: data.toMap()).then((response) => {{model}}.fromDynamic(response.data['data']));
  } 

  Future<bool> delete(int id) {
    return Client().dio.delete('{{endpointResource}}/\$id').then((response) => true).catchError((error) => false);
  }
}
''';
