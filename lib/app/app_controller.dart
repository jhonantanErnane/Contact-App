import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import './shared/services/auth_service.dart';
part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  final _authService = Modular.get<AuthService>();

  _AppControllerBase() {
    _init();
  }

  _init() {
    _authService.loginFirebase();
  }
}
