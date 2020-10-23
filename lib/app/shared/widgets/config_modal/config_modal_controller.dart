import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../services/sync_service.dart';
part 'config_modal_controller.g.dart';

class ConfigModalController = _ConfigModalControllerBase
    with _$ConfigModalController;

abstract class _ConfigModalControllerBase with Store {
  final _syncService = Modular.get<SyncService>();

  _ConfigModalControllerBase() {
    isSyncAutoStream =
        ObservableStream(_syncService.isSyncAutoOut, initialValue: false);
  }

  @observable
  ObservableStream<bool> isSyncAutoStream;

  @action
  Future<void> toggleSync(bool toggle) async {
    _syncService.setIsSyncAuto(toggle);
  }

}
