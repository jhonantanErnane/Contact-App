import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import 'shared/services/sync_log_service.dart';
import 'shared/services/storage_image_service.dart';
import 'shared/widgets/sync_progress/sync_progress_controller.dart';
import 'shared/services/contact_service.dart';
import './app_controller.dart';
import './modules/about/about_module.dart';
import './modules/contact/contact_module.dart';
import 'shared/repositories/local_repository/local_repository_sqlite.dart';
import './app_widget.dart';
import './modules/home/home_module.dart';
import 'modules/view_contact/view_contact_module.dart';
import './shared/services/auth_service.dart';
import './shared/custom_dio/custom_dio.dart';
import './shared/repositories/local_repository/local_repository_shared_preferences_service.dart';
import 'shared/services/sync_service.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        $SyncLogService,
        $StorageImageService,
        $SyncProgressController,
        $ContactService,
        $SyncService,
        $LocalRepositorySqlite,
        Bind((i) => AppController(), lazy: false),
        Bind<AuthService>((i) => AuthService.instance),
        Bind<CustomDio>((i) => CustomDio.instance),
        Bind<LocalRepositorySharedPreferencesService>(
            (i) => LocalRepositorySharedPreferencesService.instance),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, module: HomeModule()),
        ModularRouter('/contacts', module: ContactModule()),
        ModularRouter('/view/', module: ViewContactModule()),
        ModularRouter('/about', module: AboutModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
