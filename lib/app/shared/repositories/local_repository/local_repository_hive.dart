import 'dart:async';
import 'package:contact_app/app/shared/models/contact_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../repository_interface.dart';

class LocalStorageHive implements ILocalRepository {
  static const KEYBOX = 'contacts';
  Completer<Box<ContactModel>> _instance = Completer<Box<ContactModel>>();

  LocalStorageHive() {
    _init();
  }

  _init() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter<ContactModel>(ContactModelAdapter());
    var boxContact = await Hive.openBox<ContactModel>(KEYBOX);
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
    boxContact.deleteFromDisk();
  }

  @override
  Future<List<ContactModel>> getAllContacts() async {
    var boxContact = await _instance.future;
    Map<dynamic, dynamic> raw = boxContact.toMap();
    List<ContactModel> contacts = List<ContactModel>();
    raw.forEach((key, value) {
      value.id = key;
      contacts.add(value);
    });
    return contacts;
  }

  @override
  Future<ContactModel> getContact(int id) async {
    var boxContact = await _instance.future;
    return boxContact.getAt(id);
  }

  @override
  Future<void> putContact(ContactModel contact) async {
    var boxContact = await _instance.future;
    boxContact.putAt(contact.id, contact);
  }

  @override
  Future<void> deleteContact(int id) async {
    var boxContact = await _instance.future;
    boxContact.deleteAt(id);
  }
}
