import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:udhaar/models/Loan_Model.dart';
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
        friendsLended: documentSnapshot.data()["Friends_Lended"],
        friendsOwed: documentSnapshot.data()["Friends_Owed"],
        pendingLoanApprovalsRequests:
            documentSnapshot.data()["Pending_Loan_Approvals_Requests"],
        pendingPaybackConfirmations:
            documentSnapshot.data()["Pending_Payback_Confirmations"],
        pendingLoanApprovalsRequestsCount:
            documentSnapshot.data()["Pending_Loan_Approvals_Requests_Count"],
        pendingPaybackConfirmationsCount:
            documentSnapshot.data()["Pending_Payback_Confirmations_Count"],
        totalAmountLended: documentSnapshot.data()["Total_Amount_Lended"],
        totalAmountOwed: documentSnapshot.data()["Total_Amount_Owed"],
        totalFriendsLended: documentSnapshot.data()["Total_Friends_Lended"],
        totalFriendsOwed: documentSnapshot.data()["Total_Friends_Owed"],
        totalFriends: documentSnapshot.data()["Total_Friends"],
        totalRequests: documentSnapshot.data()["Total_Requests"],
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
      'Friend_List': user.friendList.join(','),
//      'friends_Lended': user.friendsLended.join(','),
//      'friends_Owed': user.friendsOwed.join(','),
//      'Pending_Loan_Approvals_Requests':
//          user.PendingLoanApprovalsRequests.join(','),
//      'Pending_Payback_Confirmations':
//          user.PendingPaybackConfirmations.join(','),
      'Friends_Lended': user.friendsLended,
      'Friends_Owed': user.friendsOwed,
      'Pending_Loan_Approvals_Requests': user.pendingLoanApprovalsRequests,
      'Pending_Payback_Confirmations': user.pendingPaybackConfirmations,
      'Pending_Loan_Approvals_Requests_Count':
          user.pendingLoanApprovalsRequestsCount,
      'Pending_Payback_Confirmations_Count':
          user.pendingPaybackConfirmationsCount,
      'Total_Amount_Lended': user.totalAmountLended,
      'Total_Amount_Owed': user.totalAmountOwed,
      'Total_Friends_Lended': user.totalFriendsLended,
      'Total_Friends_Owed': user.totalFriendsOwed,
      'Total_Friends': user.totalFriends,
      'Total_Requests': user.totalRequests,
      //    new DateFormat("dd/MM/yyyy").parse("11/11/2011");
    });
  }
  return true;
}

Future<bool> addLoanToDb(LoanModel loanObj) async {
  CollectionReference loans = FirebaseFirestore.instance.collection('Loans');
  bool internetCheckVar = await internetCheck();
  if (internetCheckVar == false)
    return false;
  else {
    await loans.doc().set({
      'Loan_From': loanObj.loanFrom.toString(),
      'Loan_To': loanObj.loanTo.toString(),
      'Status': loanObj.status.toString(),
      'Amount': loanObj.amount,
      'Tenure': loanObj.tenure,
      'Date': loanObj.date,
      //    new DateFormat("dd/MM/yyyy").parse("11/11/2011");
    });
  }
  return true;
}
