import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/subjects.dart';

import '../models/contact.dart';
import '../repositories/repository_interface.dart';
import '../repositories/local_repository/local_repository_shared_preferences_service.dart';
import 'contact_service.dart';

part 'sync_service.g.dart';

@Injectable(lazy: false)
class SyncService extends Disposable {
  final _localRepositoryService =
      Modular.get<LocalRepositorySharedPreferencesService>();
  final _storage = Modular.get<ILocalRepository>();
  final _contactService = Modular.get<ContactService>();

  final _isSyncAutoCtrl = BehaviorSubject<bool>();

  SyncService() {
    _init();
  }

  bool _isSyncAuto;

  Future<void> _init() async =>
      setIsSyncAuto(await _localRepositoryService.getAutoSync());

  Stream<bool> get isSyncAutoOut => _isSyncAutoCtrl.stream;

  void setIsSyncAuto(bool isSyncAuto) {
    _isSyncAuto = isSyncAuto;
    _isSyncAutoCtrl.add(isSyncAuto);
  }

  synchronizing() async {
    // For sync first send all
    List<int> listContactIds = await _storage.getContactsNotSync();
    if (listContactIds.length > 0) {
      //send all contacts
      for (int id in listContactIds) {
        Contact contactUpdated = await _contactService.sendContact(id);
        await _storage.putContact(contactUpdated);
      }
    }
    // get all contacts that not already is in the device
    // List<String> ids = await _storage.getAllContactsIds();
  }

  @override
  void dispose() {
    _isSyncAutoCtrl.close();
  }
}
