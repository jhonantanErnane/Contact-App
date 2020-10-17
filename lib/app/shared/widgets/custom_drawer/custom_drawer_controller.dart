import 'package:contact_app/app/shared/services/auth_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'custom_drawer_controller.g.dart';

class CustomDrawerController = _CustomDrawerBase with _$CustomDrawerController;

abstract class _CustomDrawerBase with Store {
  final _authService = Modular.get<AuthService>();

  @observable
  ObservableStream<bool> isloggedStream;

  _CustomDrawerBase() {
    isloggedStream = ObservableStream(_authService.isLogged);
  }
}
