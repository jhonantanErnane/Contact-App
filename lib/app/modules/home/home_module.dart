import 'package:flutter_modular/flutter_modular.dart';
import '../../modules/home/home_controller.dart';
import '../../shared/widgets/config_modal/config_modal_controller.dart';
import '../../shared/widgets/contact_list/contact_list_controller.dart';
import '../../modules/home/home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ContactListController()),
        Bind((i) => HomeController()),
        Bind((i) => ConfigModalController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
