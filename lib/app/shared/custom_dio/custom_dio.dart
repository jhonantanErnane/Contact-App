import 'package:dio/dio.dart';

class CustomDio {
  static CustomDio _instance;

  CustomDio._();

  static CustomDio get instance {
    _instance ??= CustomDio._();
    return _instance;
  }

  Dio get client => _init();

  _init() {
    BaseOptions options = new BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com/',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    final dio = Dio(options);
    // dio.interceptors.add(element)
    return dio;
  }
}
