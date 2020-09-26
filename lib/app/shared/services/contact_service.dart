import 'package:flutter_modular/flutter_modular.dart';
import '../custom_dio/custom_dio_builder/custom_dio_builder.dart';
import '../repositories/repository_interface.dart';

part 'contact_service.g.dart';

@Injectable()
class ContactService extends Disposable {
  final _storage = Modular.get<ILocalRepository>();

   postContact(int contactId) async {
    try {
      final contact = await _storage.getContact(contactId);
      final resp = await CustomDioBuilder.instance
          .post()
          .path('/contacts')
          .params()
          .data(contact.toJson())
          .run();
      print(resp);
    } catch (e) {
      print(e);
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
