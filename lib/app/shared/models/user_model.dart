import 'package:firebase_auth/firebase_auth.dart';

class User {
  String email;
  String displayName;
  bool isAnonymous;
  String photoUrl;
  String uid;

  User({
    this.email,
    this.displayName,
    this.isAnonymous,
    this.photoUrl,
    this.uid,
  });

  User.fromFirebaseUser(FirebaseUser fbUser) {
    this.email = fbUser.email;
    this.displayName = fbUser.displayName;
    this.isAnonymous = fbUser.isAnonymous;
    this.photoUrl = fbUser.photoUrl;
    this.uid = fbUser.uid;
  }
}
