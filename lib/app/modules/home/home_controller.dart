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

  _HomeControllerBase() {
    getContacts();
  }

  Future<void> getContacts() async {
    contacts = await _storage.getAllContacts();
  }
}
