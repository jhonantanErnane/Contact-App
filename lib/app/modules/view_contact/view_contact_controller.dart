import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/models/contact.dart';
import '../../shared/repositories/repository_interface.dart';
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
  Contact contact = Contact();

  _ViewContactControllerBase() {
    _init();
  }

  Future<void> _init() async {
    if (Modular.args.params != null) {
      await getContact();
    }
  }

  @action
  Future<void> getContact() async {
    contact = await _storage.getContact(int.parse(Modular.args.params['id']));
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

  void whatsAppOpen(phoneNumber, message) async {
    await FlutterLaunch.launchWathsApp(
        phone: '55' + phoneNumber, message: message);
  }

  textMe(String number) async {
    // Android
    String uri = "sms:$number";
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      String uri = "sms:$number";
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  launchCaller(String number) async {
    String url = "tel:$number";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
