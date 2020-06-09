import 'package:contact_app/app/shared/models/contact_model.dart';

abstract class ILocalRepository {
  Future<List<ContactModel>> getAllContacts();
  Future<void> addContact(ContactModel contact);
  Future<void> putContact(List<ContactModel> contacts);
  Future<void> delContacts();

}
