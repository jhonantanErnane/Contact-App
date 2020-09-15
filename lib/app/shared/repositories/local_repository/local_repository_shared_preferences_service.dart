import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRepositorySharedPreferencesService extends Disposable {
  static SharedPreferences _preferences;
  static LocalRepositorySharedPreferencesService _service;
  static const String ISAUTOSYNCKEY = 'autosync';

  LocalRepositorySharedPreferencesService._();

  static LocalRepositorySharedPreferencesService get instance {
    if (_service == null) {
      _service = LocalRepositorySharedPreferencesService._();
    }
    return _service;
  }

  Future<void> _getInstance() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
  }

  Future<bool> setAutoSync(bool isAuto) async {
    await _getInstance();
    await _preferences.setBool(ISAUTOSYNCKEY, isAuto ?? false);
    return isAuto;
  }

  Future<bool> getAutoSync() async {
    await _getInstance();
    return _preferences.getBool(ISAUTOSYNCKEY);
  }

  @override
  void dispose() {}
}
