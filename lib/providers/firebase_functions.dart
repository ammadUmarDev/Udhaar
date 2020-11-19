import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'package:udhaar/models/User_Model.dart';

Future<bool> checkUniquenessOfEMAIL(String email) async {
  // ignore: deprecated_member_use
  Firestore firestore = Firestore.instance;
  // ignore: deprecated_member_use
  var snapshot = await firestore.collection('Users').document(email).get();
  return snapshot.data == null;
}

Future<bool> internetCheck() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('Internet connected');
    }
  } on SocketException catch (_) {
    print('No internet connection');
    return false;
  }
  return true;
}

//Password Change
Future<bool> changePassword(UserModel u, String enteredPass) async {
  User user = FirebaseAuth.instance.currentUser;
  await user.updatePassword(enteredPass).then((_) async {
    print("Succesfully changed auth password");
    return true;
  }).catchError((error) {
    print("Password can't be changed" + error.toString());
    return false;
    //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
  });
}

//User Name Change
Future<bool> changeFullName(UserModel u, String newName) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference users = db.collection('Users');
  bool check = false;
  await users
      .doc(u.userID)
      .update({'Full_Name': newName})
      .then((value) => check = true)
      .catchError((error) => print("Failed to update user: $error"));

  return check;
}

//Future<String> upload_file(File file /*, BuildContext context*/) async {
//  //Path p = new Path();
//  if (file == null) {
//    print("File being uploaded in null");
//  }
//  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
//  StorageReference storageReference = firebaseStorage.ref().child(file.path);
//  StorageUploadTask uploadTask = storageReference.putFile(file);
//  await uploadTask.onComplete;
//  print('File Uploaded');
//  String fileURL = await storageReference.getDownloadURL().then((fileUrl) {
//    return fileUrl;
//  });
//  return fileURL;
//}

/*retrieves firebase User document*/
Future<UserModel> getUserDocFirebase(String userId) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference users = db.collection('Users');
  await users.doc(userId).get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      print('Document exist on the database');
      UserModel returnUserModel = new UserModel(
        email: documentSnapshot.data()["Email"].toString(),
        fullName: documentSnapshot.data()["Full_Name"].toString(),
        userID: documentSnapshot.data()["User_Id"].toString(),
        createdDate: documentSnapshot.data()["Created_Date"].toString(),
        lastPassChangeDate:
            documentSnapshot.data()["Last_Pass_Change_Date"].toString(),
        friendList: documentSnapshot.data()["Friend_List"].split(","),
      );
      return returnUserModel;
    } else {
      print('Document does not exist on the database');
    }
  });
}

Future<bool> signupFirebaseDb(UserModel user) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  bool internetCheckVar = await internetCheck();
  if (internetCheckVar == false)
    return false;
  else {
    await users.doc(user.userID).set({
      'User_Id': user.userID.toString(),
      'Full_Name': user.fullName.toString(),
      'Email': user.email.toString(),
      'Created_Date': user.createdDate.toString(),
      'Last_Pass_Change_Date': user.lastPassChangeDate.toString(),
      'Friend_List': user.friendList
          .join(',') //    new DateFormat("dd/MM/yyyy").parse("11/11/2011");
    });
  }
  return true;
}
