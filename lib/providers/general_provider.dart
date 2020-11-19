import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:udhaar/models/User_Model.dart';

// ignore: camel_case_types
class General_Provider extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  FirebaseAuth auth = FirebaseAuth.instance;
  UserModel user;
  User firebaseUser;
  // ignore: non_constant_identifier_names
  UserModel get_user() {
    if (user == null) {
      print("User has not been set yet");
    }
    return user;
  }

  // ignore: non_constant_identifier_names
  void set_user(UserModel u) {
    this.user = u;
  }

  // ignore: deprecated_member_use, non_constant_identifier_names
  FirebaseUser get_firebase_user() {
    if (firebaseUser == null) {
      print("Firebase user has not been set yet");
    }
    return firebaseUser;
  }

  // ignore: non_constant_identifier_names
  void set_firebase_user(User u) {
    this.firebaseUser = u;
  }
}
