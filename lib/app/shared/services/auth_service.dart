import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../../shared/custom_dio/custom_dio.dart';
import '../../shared/repositories/repository_interface.dart';
import '../../shared/custom_dio/custom_dio_builder/custom_dio_builder.dart';
import 'dart:async';

class AuthService extends Disposable {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _storage = Modular.get<ILocalRepository>();

  static AuthService _instance;
  StreamSubscription _streamSubscription;
  User user;
  String token = '';

  static AuthService get instance {
    if (_instance == null) {
      _instance = AuthService._();
    }
    return _instance;
  }

  AuthService._() {
    _authStateChanged();
  }

  _authStateChanged() {
    _streamSubscription =
        _auth.onAuthStateChanged.listen((FirebaseUser user) async {
      if (user != null) {
        try {
          final idTokenResult = await user.getIdToken();
          this.token = idTokenResult.token;
          await getUser();
          testPostContact();
        } catch (e) {
          print(e);
        }
      }
    });
  }

  testPostContact() async {
    try {
      final contact = await _storage.getContact(1);
      final f = await CustomDioBuilder.instance
          .post()
          .path('/contacts')
          .params()
          .data(contact.toJson())
          .run();
      print(f);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUser() async {
    final _customDio = Modular.get<CustomDio>();
    try {
      final userResp = await _customDio.client.get('/user');
      print(userResp);
    } catch (e) {
      print(e);
    }
  }

  loginFirebase() async {
    FirebaseUser user = await _auth.currentUser();
    if (user == null) {
      final result = await _auth.signInAnonymously();
      user = result.user;
    }
    this.user = User.fromFirebaseUser(user);
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
  }
}
