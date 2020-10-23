import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/subjects.dart';
import '../models/user_model.dart';
import '../../shared/custom_dio/custom_dio.dart';
import 'dart:async';

class AuthService extends Disposable {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _customDio = Modular.get<CustomDio>();
  final _isLoggedCtrl = BehaviorSubject<bool>();

  static AuthService _instance;
  StreamSubscription _streamSubscription;
  User user;
  FirebaseUser firebaseUser;
  
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
      firebaseUser = user;
      if (user == null) {
        this.user = await _loginFirebase();
      }
      final resp = await _getUser();

      if (resp && this.user != null) {
        _isLoggedCtrl.add(true);
      } else {
        _isLoggedCtrl.add(false);
      }
    });
  }

  Stream<bool> get isLogged => _isLoggedCtrl.stream;

  Future<String> getToken() async {
    try {
      final idTokenResult = await firebaseUser.getIdToken();
      return idTokenResult.token;
    } catch (e) {
      print(e);
      return '';
    }
  }

  Future<bool> _getUser() async {
    try {
      final userResp = await _customDio.client.get('/user');
      print(userResp);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// Make login with Firebase
  ///
  /// If the user is not logged, make a login anonymously
  Future<User> _loginFirebase() async {
    FirebaseUser user = await _auth.currentUser();
    if (user == null) {
      final result = await _auth.signInAnonymously();
      user = result.user;
    }
    return User.fromFirebaseUser(user);
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
  }
}
