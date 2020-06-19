import 'package:contact_app/app/shared/models/contact_model.dart';

abstract class ILocalRepository {
  /// Get the list of all contacts
  ///
  /// Optinal parameter [name], will filter in all contacts by name
  Future<List<ContactModel>> getAllContacts([String name]);
  /// Get the list of all suggestions names when the user start typing
  Future<List<String>> searchAllContacts(String name);
  /// Save new Contact
  Future<void> addContact(ContactModel contact);
  /// Get a contact by id
  Future<ContactModel> getContact(int id);
  /// Edit a contact 
  Future<void> putContact(ContactModel contact);
  /// Delete a contact by id
  Future<void> deleteContact(int id);
  /// Delete all contacts
  Future<void> delContacts();

}
