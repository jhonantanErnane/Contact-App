import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../repositories/local_repository/local_repository_shared_preferences_service.dart';

part 'config_modal_controller.g.dart';

class ConfigModalController = _ConfigModalControllerBase
    with _$ConfigModalController;

abstract class _ConfigModalControllerBase with Store {
  final _sharedPreferences =
      Modular.get<LocalRepositorySharedPreferencesService>();

  _ConfigModalControllerBase() {
    _getSync();
  }

  @observable
  bool isSyncAuto;

  @action
  Future<void> _getSync() async =>
      isSyncAuto = await _sharedPreferences.getAutoSync();

  @action
  Future<void> toggleSync(bool toggle) async {
    isSyncAuto = await _sharedPreferences.setAutoSync(toggle);
  }
}
