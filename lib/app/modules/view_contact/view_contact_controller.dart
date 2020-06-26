import 'package:contact_app/app/shared/models/contact_model.dart';
import 'package:contact_app/app/shared/repositories/repository_interface.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'view_contact_controller.g.dart';

class ViewContactController = _ViewContactControllerBase
    with _$ViewContactController;

abstract class _ViewContactControllerBase with Store {
  final _storage = Modular.get<ILocalRepository>();

  @observable
  bool existWhatsapp = false;

  @observable
  bool isFavorite = false;

  @observable
  ContactModel contact;

  _ViewContactControllerBase() {
    _setupValidations();
  }

  Future<void> _setupValidations() async {
    if (Modular.args.params != null) {
      await getContact();
    }
  }

  @action
  Future<void> getContact() async {
    this.contact =
        await _storage.getContact(int.parse(Modular.args.params['id']));
    isFavorite = contact.isFavorite;
  }

  @action
  Future<void> toggleFavorite() async {
    contact.isFavorite = !contact.isFavorite;
    await _storage.putContact(contact);
    isFavorite = contact.isFavorite;
  }

  Future<void> getApps() async {
    try {
      existWhatsapp = await FlutterLaunch.hasApp(name: 'whatsapp');
    } catch (err) {
      existWhatsapp = false;
    }
  }

  onNavigation(Map<dynamic, dynamic> param) {
    if (param != null && param['loadContacts']) {
      getContact();
    }
  }
}
