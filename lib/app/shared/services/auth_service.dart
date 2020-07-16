import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import 'dart:async';

class AuthService extends Disposable {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static AuthService _instance;
  StreamSubscription _streamSubscription;
  User user;

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
    _streamSubscription = _auth.onAuthStateChanged.listen((FirebaseUser user) async {
      if (user != null) {
        final token = await user.getIdToken();
        print(token.token);
      }
    });
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
