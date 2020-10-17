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
  String _token =
      'eyJhbGciOiJSUzI1NiIsImtpZCI6IjBlM2FlZWUyYjVjMDhjMGMyODFhNGZmN2RjMmRmOGIyMzgyOGQ1YzYiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9jb250YWN0LWFwcC01NjE1MiIsImF1ZCI6ImNvbnRhY3QtYXBwLTU2MTUyIiwiYXV0aF90aW1lIjoxNjAxNDI5OTI5LCJ1c2VyX2lkIjoiMHZienpxWmpTN2FmQmlwbHRIYnByM0hJeHA3MiIsInN1YiI6IjB2Ynp6cVpqUzdhZkJpcGx0SGJwcjNISXhwNzIiLCJpYXQiOjE2MDI5NjQwNzgsImV4cCI6MTYwMjk2NzY3OCwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6e30sInNpZ25faW5fcHJvdmlkZXIiOiJhbm9ueW1vdXMifX0.Sr_EUy7eEmldmsR7_bYRU5jFSbnAI774IEPzni_xG50fCNZ-QHe33QDJ-k59Ec-Qz5QNzb663Dt06dLKz3Ocy6DhuGf3ggAld0rVTgdcP-PWD3z6abNsaMQkol357-QkHP7kMzG-96c79Ch4fu7G0pocF8f0pdfmcgDD9Zu4OOwm6nsSwEh5MGKWz7sWRRz5dURBkY_dJ6pikKxb280gXCEi_p9KnQSyLckK1NOj5xlcVGaY-lXl-PDFArOUFKl0Mr857SJ1CwQLcJJmOLhmpLtcig15_49rpyP7GzH3AkTV-SByAy62737wRG6iUoXVRmnOdo9L5ZfkNIIdX1HSRw';

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
      if (idTokenResult.token.compareTo(_token) != 0) {
        print('idTokenResult.token => ' + idTokenResult.token);
        _token = idTokenResult.token;
        print('_token => ' + _token);
      } else {
        print('======= token igual ========');
      }
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
