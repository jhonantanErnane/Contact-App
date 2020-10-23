import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../models/sync_event_enum.dart';
import '../../services/sync_service.dart';

part 'sync_progress_controller.g.dart';

@Injectable()
class SyncProgressController = _SyncProgressControllerBase
    with _$SyncProgressController;

abstract class _SyncProgressControllerBase with Store {
  final _syncService = Modular.get<SyncService>();

  void init(bool startSync) {
    if (startSync) {
      startSyncManually();
    }
  }

  @observable
  String message = '';

  @action
  void startSyncManually() {
    _syncService.startSync.takeWhile((element) {
      if (element.eventEnum != SyncEventEnum.ENDED) {
        return true;
      } else {
        Modular.to.pop();
        return false;
      }
    }).listen(
      (event) async {
        print(event.message);
        message = event.message;
      },
    );
  }
}
