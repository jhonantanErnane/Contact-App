import 'package:contact_app/app/shared/models/contact_model.dart';

abstract class ILocalRepository {
  Future<List<ContactModel>> getAllContacts();
  Future<void> addContact(ContactModel contact);
  Future<ContactModel> getContact(int id);
  Future<void> putContact(ContactModel contact);
  Future<void> deleteContact(int id);
  Future<void> delContacts();

}
