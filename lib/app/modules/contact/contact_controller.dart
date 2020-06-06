import 'package:mobx/mobx.dart';

part 'contact_controller.g.dart';

class ContactController = _ContactControllerBase with _$ContactController;

abstract class _ContactControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
