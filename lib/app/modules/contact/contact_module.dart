import 'package:contact_app/app/modules/contact/contact_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:contact_app/app/modules/contact/contact_page.dart';

class ContactModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ContactController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => ContactPage()),
        ModularRouter('/add', child: (_, args) => ContactPage()),
        ModularRouter('/edit/:id', child: (_, args) => ContactPage()),
      ];

  static Inject get to => Inject<ContactModule>.of();
}
