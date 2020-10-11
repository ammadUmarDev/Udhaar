import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:udhaar/models/User_Model.dart';

// ignore: camel_case_types
class General_Provider extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  FirebaseAuth auth = FirebaseAuth.instance;
  UserModel user;
  User firebaseUser;
  UserModel get_user() {
    if (user == null) {
      print("User has not been set yet");
    }
    return user;
  }

  void set_user(UserModel u) {
    this.user = u;
  }

  FirebaseUser get_firebase_user() {
    if (firebaseUser == null) {
      print("Firebase user has not been set yet");
    }
    return firebaseUser;
  }

  void set_firebase_user(User u) {
    this.firebaseUser = u;
  }
}
