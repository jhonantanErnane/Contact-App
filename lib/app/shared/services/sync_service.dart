import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/subjects.dart';
import '../repositories/local_repository/local_repository_shared_preferences_service.dart';

part 'sync_service.g.dart';

@Injectable(lazy: false)
class SyncService extends Disposable {
  final _localRepositoryService =
      Modular.get<LocalRepositorySharedPreferencesService>();

  final _isSyncAutoCtrl = BehaviorSubject<bool>();

  SyncService() {
    _init();
  }

  bool _isSyncAuto;

  Future<void> _init() async =>
      setIsSyncAuto(await _localRepositoryService.getAutoSync());

  Stream<bool> get isSyncAutoOut => _isSyncAutoCtrl.stream;

  void setIsSyncAuto(bool a) {
    _isSyncAuto = a;
    _isSyncAutoCtrl.add(a);
  }

  @override
  void dispose() {
    _isSyncAutoCtrl.close();
  }
}
