import 'package:contact_app/app/modules/view_contact/view_contact_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:contact_app/app/modules/view_contact/view_contact_page.dart';

class ViewContactModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ViewContactController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => ViewContactPage()),
        Router('/:id', child: (_, args) => ViewContactPage()),
      ];

  static Inject get to => Inject<ViewContactModule>.of();
}
