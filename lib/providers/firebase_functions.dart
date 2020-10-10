import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import 'package:udhaar/models/User_Model.dart';

Future<bool> checkUniquenessOfEMAIL(String email) async {
  // ignore: deprecated_member_use
  Firestore firestore = Firestore.instance;
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

//Change UserType
Future<bool> update_User_Type(UserModel user) async {
  var firestore = Firestore.instance;
  await firestore.collection('Users').document(user.email).delete();
  await firestore.collection('Users').document(user.email).setData({
    'Full_Name': user.fullName.toString(),
    'Email': user.email.toString(),
    'Password': user.pass.toString(),
  });
  return true;
}

//Password Change
Future<bool> changePassword(
    UserModel u, String new_Pass, String entered_pass) async {
  if (u.pass == entered_pass) {
    // ignore: await_only_futures
    print("Entered");
    var fire = Firestore.instance;
    await fire.collection("Users").document(u.email).updateData({
      "Password": new_Pass.toString(),
    });
    return true;
  } else {
    return false;
  }
}

//User Name Change
Future<bool> change_User_Name(UserModel u, String new_name) async {
  var fire = Firestore.instance;
  await fire
      .collection("Users")
      .document(u.fullName)
      .updateData({"Full_Name": new_name});
  return true;
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
Future<UserModel> getUser(String userId) async {
  Firestore firestore = Firestore.instance;
  var snapshot = await firestore.collection('Users').document(userId).get();
  if (snapshot.data != null) {
    return UserModel(
      email: snapshot.data()["Email"].toString(),
      pass: snapshot.data()["Password"].toString(),
      fullName: snapshot.data()["Full_Name"].toString(),
      userID: snapshot.data()["User_ID"].toString(),
      createdDate: snapshot.data()["Created_Date"].toString(),
      lastPassChangeDate: snapshot.data()["Last_Pass_Change_Date"].toString(),
    );
  }
  return null;
}

Future<bool> signupFirebaseDb(UserModel user) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  bool internetCheck_ = await internetCheck();
  if (internetCheck_ == false)
    return false;
  else {
    users.add({
      'User_Id': user.userID.toString(),
      'Full_Name': user.fullName.toString(),
      'Email': user.email.toString(),
      'Password': user.pass.toString(),
      'Created_Date': user.createdDate.toString(),
      'Last_Pass_Change_Date': user.lastPassChangeDate
          .toString(), //    new DateFormat("dd/MM/yyyy").parse("11/11/2011");
    });
  }
  return true;
}
