import 'package:contact_app/app/shared/models/contact.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'dart:async';
import '../../shared/repositories/repository_interface.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final _storage = Modular.get<ILocalRepository>();

  @observable
  ObservableList<Contact> contacts = ObservableList<Contact>();

  @observable
  bool isLoading;

  _HomeControllerBase() {
    getContacts();
  }

  @action
  Future<void> getContacts() async {
    isLoading = true;
    contacts = (await _storage.getAllContacts()).asObservable();
    isLoading = false;
  }

  @action
  Future<void> delContact(int id) async {
    isLoading = true;
    await _storage.deleteContact(id);
    getContacts();
    isLoading = false;
  }

  @action
  Future<void> delContacts() async {
    isLoading = true;
    await _storage.delContacts();
    getContacts();
    isLoading = false;
  }

  onNavigation(Map<dynamic, dynamic> param) {
    if (param != null) {
      if (param['loadContacts'] != null) {
        getContacts();
      } else if (param['loadContact'] != null) {
        getContact(param['loadContact']);
      }
    }
  }

  @action
  Future<void> getContact(int id) async {
    final contact = await _storage.getContact(id);
    final i = contacts.indexWhere((element) => element.id == contact.id);
    if (i != -1) {
      contacts = contacts
          .map((element) =>
              element.id == contact.id ? element = contact : element)
          .toList()
          .asObservable();
    }
  }
}
