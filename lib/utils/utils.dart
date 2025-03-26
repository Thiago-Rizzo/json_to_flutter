import 'dart:io';

Future<void> writeToFile(String path, String content, {bool append = true}) async {
  final file = File(path);

  if (file.existsSync() && !append) {
    return;
  }

  if (!file.existsSync()) {
    file.createSync(recursive: true);
  }

  await file.writeAsString(content);
}

String readFile(String? path, String defaultValue) {
  if (path == null || !File(path).existsSync()) {
    return defaultValue;
  }

  return File(path).readAsStringSync();
}
