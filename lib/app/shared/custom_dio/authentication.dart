import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../shared/services/auth_service.dart';

class AuthenticationInterceptorDio implements InterceptorsWrapper {
  final _authService = Modular.get<AuthService>();
  static AuthenticationInterceptorDio _instance;

  AuthenticationInterceptorDio._();

  static AuthenticationInterceptorDio get instance {
    _instance ??= AuthenticationInterceptorDio._();
    return _instance;
  }

  @override
  Future onError(DioError err) async {
    return err;
  }

  @override
  Future onRequest(RequestOptions options) async {
    final token = await _authService.getToken();
    options.headers['Authorization'] = 'Bearer $token';
    return options;
  }

  @override
  Future onResponse(Response response) async {
    return response;
  }
}
