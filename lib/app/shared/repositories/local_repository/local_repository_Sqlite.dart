import 'dart:async';

import '../../models/contact.dart';
import '../repository_interface.dart';
import 'package:sqflite/sqflite.dart';

const String DBNAME = 'flutter_contacts.db';
const int DBVERSION = 1;

// tb lista
const List<String> dbCreate = [
  '''CREATE TABLE contacts(
      id INTEGER PRIMARY KEY,
      name TEXT,
      nickName TEXT,
      work TEXT,
      isFavorite INTEGER,
      photo TEXT,
      phoneNumber TEXT,
      email TEXT,
      webSite TEXT)'''
];

class LocalStorageSqlite extends ILocalRepository {
  Completer<Database> _dbInstance = Completer<Database>();

  LocalStorageSqlite() {
    _init();
  }

  _init() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + DBNAME;
    await deleteDatabase(path);
    Database db =
        await openDatabase(path, version: DBVERSION, onOpen: (Database db) {
      print(db);
    }, onCreate: (Database db, int version) async {
      dbCreate.forEach((String sql) async {
        try {
          await db.execute(sql);
        } catch (e) {
          print(e);
        }
      });
    });
    _dbInstance.complete(db);
  }

  @override
  Future<void> addContact(Contact contact) async {}

  @override
  Future<void> delContacts() async {}

  /// Get all contacts
  ///
  /// Optinal parameter [name], will filter in all contacts by name
  @override
  Future<List<Contact>> getAllContacts([String name]) async {
    try {
      final dbInstance = await _dbInstance.future;
      final contactsMap = await dbInstance.query('contacts');
      print(contactsMap);
      return [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<String>> searchAllContacts(String name) async {}

  @override
  Future<Contact> getContact(int id) async {}

  @override
  Future<void> putContact(Contact contact) async {}

  @override
  Future<void> deleteContact(int id) async {}
}
