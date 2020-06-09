import 'dart:async';
import 'package:contact_app/app/shared/models/contact_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../repository_interface.dart';


class LocalStorageHive implements ILocalRepository {
  static const KEYBOX = 'contactsList';
  Completer<Box> _instance = Completer<Box>();

  LocalStorageHive() {
    _init();
  }

  _init() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter<ContactModel>(ContactModelAdapter());
    var boxContact = await Hive.openBox('contacts');
    _instance.complete(boxContact);
  }

  @override
  Future<void> addContact(ContactModel contact) async {
    var boxContact = await _instance.future;
    boxContact.add(contact);
  }

  @override
  Future<void> delContacts() async {
    var boxContact = await _instance.future;
    boxContact.delete(KEYBOX);
  }

  @override
  Future<List<ContactModel>> getAllContacts() async {
    var boxContact = await _instance.future;
    Map<dynamic, dynamic> raw = boxContact.toMap();
    return raw.values.map<ContactModel>((c) => c).toList();
  }

  @override
  Future<void> putContact(List<ContactModel> contacts) async {
    var boxContact = await _instance.future;
    boxContact.put(KEYBOX, contacts);
  }
}
