import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:udhaar/components/appbar.dart';
import 'package:udhaar/components/body_text.dart';
import 'package:udhaar/components/h1.dart';
import 'package:udhaar/components/h2.dart';
import 'package:udhaar/components/h3.dart';
import 'package:udhaar/models/User_Model.dart';
import 'package:udhaar/providers/general_provider.dart';

import '../../../constants.dart';

class PendingPaidbackConfirmations extends StatefulWidget {
  @override
  _PendingPaidbackConfirmationsState createState() =>
      _PendingPaidbackConfirmationsState();
}

class _PendingPaidbackConfirmationsState
    extends State<PendingPaidbackConfirmations> {
  List<String> pendingPaybackConfirmations;
  @override
  Future<void> initState() {
    getUser();
  }

  Future<void> getUser() async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(Provider.of<General_Provider>(context, listen: false)
            .firebaseUser
            .uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exist on the database');
        UserModel retGetUserObjFirebase = UserModel(
          email: documentSnapshot.data()["Email"].toString(),
          fullName: documentSnapshot.data()["Full_Name"].toString(),
          userID: documentSnapshot.data()["User_Id"].toString(),
          createdDate: documentSnapshot.data()["Created_Date"].toString(),
          lastPassChangeDate:
              documentSnapshot.data()["Last_Pass_Change_Date"].toString(),
          friendList: documentSnapshot.data()["Friend_List"].split(","),
          friendsLended: List.from(documentSnapshot.data()["Friends_Lended"]),
          friendsOwed: List.from(documentSnapshot.data()["Friends_Owed"]),
          pendingLoanApprovalsRequests: List.from(
              documentSnapshot.data()["Pending_Loan_Approvals_Requests"]),
          pendingPaybackConfirmations: List.from(
              documentSnapshot.data()["Pending_Payback_Confirmations"]),
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
        setState(() {
          Provider.of<General_Provider>(context, listen: false)
                  .user
                  .pendingPaybackConfirmations =
              retGetUserObjFirebase.pendingPaybackConfirmations;
          pendingPaybackConfirmations =
              retGetUserObjFirebase.pendingPaybackConfirmations;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget pendingPaybackConfirmations = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: Provider.of<General_Provider>(context, listen: false)
            .user
            .pendingPaybackConfirmations
            .asMap()
            .entries
            .map(
              (e) => InkWell(
                onTap: () {
                  Alert(
                      context: context,
                      title: "Coming Soon",
                      style: AlertStyle(
                        titleStyle: H2TextStyle(color: kPrimaryAccentColor),
                      ),
                      content: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          H3(textBody: "Stay tuned for the next update :)"),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      buttons: [
                        DialogButton(
                          color: Colors.white,
                          height: 0,
                          child: SizedBox(height: 0),
                          onPressed: () {},
                        ),
                      ]).show();
                },
                child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    elevation: 0,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Icon(
                            FontAwesomeIcons.userMinus,
                            color: kIconColor,
                            size: iconSize,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          H3(textBody: e.value),
                          SizedBox(
                            height: 5,
                          ),
                          BodyText(
                            textBody: "Tap me to request loan",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )),
              ),
            )
            .toList());
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBarPageName(
        pageName: "Paidback Confirmations",
        helpAlertTitle: "Loan Payback Confirmations Help",
        helpAlertBody: "Tap to confirm whether loan is returned or not.",
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [],
                    ),
                  ),
                ),
              ];
            },
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 5.0),
              child: pendingPaybackConfirmations,
            ),
          ),
        ),
      ),
    );
  }
}
