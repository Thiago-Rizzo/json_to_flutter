String getStub() => '''
import 'package:dio/dio.dart';

class Client {
  late Dio _dio;

  Client() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost/api',
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // options.headers['Authorization'] = 'Bearer \$token';
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
''';
