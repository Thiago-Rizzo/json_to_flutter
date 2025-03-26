String getStub() => '''
{{imports}}

class {{className}} {
  final {{service}} service;
  
  const {{className}}({this.service = const {{service}}()});

  final List<{{model}}> items = const <{{model}}>[];
  
  Future<List<{{model}}>> getAll() async {
    items.addAll(await service.getAll());

    return items;
  }

  Future<{{model}}?> getById(int id) async {
    return getByIdLocal(id) ?? await service.getById(id);
  }

  {{model}}? getByIdLocal(int id) {
    final filtered = items.where((item) => item.id == id);

    return filtered.isNotEmpty ? filtered.first : null;
  }

  Future<{{model}}> create({{model}} data) async {
    final item = await service.create(data);

    await service.getAll();

    return item;
  }

  Future<{{model}}> update({{model}} data) async {
    final item = await service.update(data);

    await service.getAll();

    return item;
  }

  Future<bool> delete(int id) async {
    final result = await service.delete(id);

    await service.getAll();

    return result;
  }
}
''';
