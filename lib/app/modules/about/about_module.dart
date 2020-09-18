import 'package:contact_app/app/modules/about/about_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:contact_app/app/modules/about/about_page.dart';

class AboutModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AboutController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => AboutPage()),
      ];

  static Inject get to => Inject<AboutModule>.of();
}
