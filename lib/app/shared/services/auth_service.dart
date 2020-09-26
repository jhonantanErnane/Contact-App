import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../../shared/custom_dio/custom_dio.dart';
import 'dart:async';

class AuthService extends Disposable {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      if (user == null) {
        _loginFirebase();
      } else {
        try {
          final idTokenResult = await user.getIdToken();
          this.token = idTokenResult.token;
          await _getUser();
        } catch (e) {
          print(e);
        }
      }
    });
  }

  Future<void> _getUser() async {
    final _customDio = Modular.get<CustomDio>();
    try {
      final userResp = await _customDio.client.get('/user');
      print(userResp);
    } catch (e) {
      print(e);
    }
  }

  _loginFirebase() async {
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
