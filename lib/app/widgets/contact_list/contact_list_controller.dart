import 'package:mobx/mobx.dart';

part 'contact_list_controller.g.dart';

class ContactListController = _ContactListControllerBase
    with _$ContactListController;

abstract class _ContactListControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
