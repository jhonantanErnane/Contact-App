import 'package:contact_app/app/shared/models/contact_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../shared/repositories/repository_interface.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final _storage = Modular.get<ILocalRepository>();

  @observable
  List<ContactModel> contacts;

  @observable
  bool isLoading;

  _HomeControllerBase() {
    getContacts();
  }

  @action
  Future<void> getContacts() async {
    isLoading = true;
    contacts = await _storage.getAllContacts();
    isLoading = false;
  }
}
