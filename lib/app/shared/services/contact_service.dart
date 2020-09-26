import 'package:contact_app/app/shared/models/contact.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../custom_dio/custom_dio_builder/custom_dio_builder.dart';
import '../repositories/repository_interface.dart';

part 'contact_service.g.dart';

@Injectable()
class ContactService extends Disposable {
  final _storage = Modular.get<ILocalRepository>();

  Future<Contact> sendContact(int contactId) async {
    Contact contact = await _storage.getContact(contactId);
    try {
      if (contact.idServer == null) {
        return await _postContact(contact);
      } else {
        return await _putContact(contact);
      }
    } catch (e) {
      return contact;
    }
  }

  Future<Contact> _postContact(Contact contact) async {
    try {
      final resp = await CustomDioBuilder.instance
          .post()
          .path('/contacts')
          .params()
          .data(contact.toJson())
          .run();
      return Contact.fromJson(resp.data);
    } catch (e) {
      print(e);
      throw Exception(
          'Ops ocorreu um erro, ao sincronizar um contato, por favor tente novamente');
    }
  }

  Future<Contact> _putContact(Contact contact) async {
    try {
      final resp = await CustomDioBuilder.instance
          .put()
          .path('/contacts')
          .params()
          .data(contact.toJson())
          .run();
      return Contact.fromJson(resp.data);
    } catch (e) {
      print(e);
      throw Exception(
          'Ops ocorreu um erro, ao sincronizar um contato, por favor tente novamente');
    }
  }

  getAllContacts() async {
    try {
      final resp =
          await CustomDioBuilder.instance.get().path('/contacts').run();
      print(resp);
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {}
}
