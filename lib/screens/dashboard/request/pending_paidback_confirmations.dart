import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:udhaar/components/appbar.dart';
import 'package:udhaar/components/body_text.dart';
import 'package:udhaar/components/button_loading.dart';
import 'package:udhaar/components/h1.dart';
import 'package:udhaar/components/h2.dart';
import 'package:udhaar/components/h3.dart';
import 'package:udhaar/components/rounded_button.dart';
import 'package:udhaar/components/rounded_input_field.dart';
import 'package:udhaar/models/Loan_Model.dart';
import 'package:udhaar/models/User_Model.dart';
import 'package:udhaar/providers/general_provider.dart';
import 'package:udhaar/screens/dashboard/stats/components/grid_tile_user.dart';

import '../../../constants.dart';

class PendingPaidbackConfirmations extends StatefulWidget {
  @override
  _PendingPaidbackConfirmationsState createState() =>
      _PendingPaidbackConfirmationsState();
}

class _PendingPaidbackConfirmationsState
    extends State<PendingPaidbackConfirmations> {
  List<String> pendingPaybackConfirmations = [];
  List<LoanModel> pendingPaybackConfirmationsAsLoans = [];
  List<String> loanIds = [];
  @override
  void initState() {
    getUser();
  }

  void getUser() async {
    await FirebaseFirestore.instance
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
          pendingPaybackConfirmationsAsLoans = [];
          Provider.of<General_Provider>(context, listen: false)
                  .user
                  .pendingPaybackConfirmations =
              retGetUserObjFirebase.pendingPaybackConfirmations;
          pendingPaybackConfirmations =
              retGetUserObjFirebase.pendingPaybackConfirmations;
          for (var i = 0; i < pendingPaybackConfirmations.length; i++) {
            List<String> tempL = pendingPaybackConfirmations[i].split(',');
            LoanModel lm = LoanModel(
                loanFrom: tempL[0],
                loanTo: tempL[1],
                status: tempL[2],
                amount: int.parse(tempL[3]),
                tenure: int.parse(tempL[4]),
                date: tempL[5],
                approvalStatus: tempL[6],
                id: tempL[7]);
            lm.print_loan();
            pendingPaybackConfirmationsAsLoans.add(lm);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget pendingPaybackConfirmations = ListView(
        children: pendingPaybackConfirmationsAsLoans
            .asMap()
            .entries
            .map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: kTextLightColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.handHoldingUsd,
                                    color: kIconColor,
                                  ),
                                  SizedBox(width: 20),
                                  H3(textBody: "Confirm payment from"),
                                  SizedBox(width: 10),
                                  H2(
                                      textBody: e.value.loanTo.substring(
                                          0,
                                          e.value.loanTo
                                              .toString()
                                              .indexOf("@")),
                                      color: kPrimaryAccentColor),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BodyText(
                                            textBody: "•  Amount: PKR " +
                                                e.value.amount.toString(),
                                            color: kTextDarkColor),
                                        SizedBox(height: 5),
                                        BodyText(
                                            textBody: "•  Tenure: " +
                                                e.value.tenure.toString() +
                                                " months",
                                            color: kTextDarkColor),
                                        SizedBox(height: 5),
                                        BodyText(
                                            textBody: "•  Approval Status: " +
                                                e.value.approvalStatus
                                                    .toString(),
                                            color: kTextDarkColor),
                                        SizedBox(height: 5),
                                        BodyText(
                                            textBody: "•  Payback Status: " +
                                                e.value.status.toString(),
                                            color: kTextDarkColor),
                                        SizedBox(height: 5),
                                        BodyText(
                                            textBody: "•  Requested Date: " +
                                                e.value.date.toString(),
                                            color: kTextDarkColor),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipOval(
                                          child: Material(
                                            color: Colors
                                                .transparent, // button color
                                            child: InkWell(
                                              splashColor:
                                                  kPrimaryAccentColor, // inkwell color
                                              child: SizedBox(
                                                width: 50,
                                                height: 30,
                                                child: Icon(
                                                  Icons.check,
                                                  color: kPrimaryAccentColor,
                                                ),
                                              ),
                                              onTap: () {
                                                Alert(
                                                    context: context,
                                                    title: "Approve Loan",
                                                    style: AlertStyle(
                                                      titleStyle: H2TextStyle(
                                                          color:
                                                              kPrimaryAccentColor),
                                                    ),
                                                    content: Column(
                                                      children: <Widget>[
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            RoundedButton(
                                                              text: "Cancel",
                                                              textColor:
                                                                  kTextDarkColor,
                                                              press: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                            ButtonLoading(
                                                                labelText:
                                                                    "Confirm",
                                                                onTap: () {
                                                                  setState(
                                                                    () {
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'Loans')
                                                                          .doc(e
                                                                              .value
                                                                              .id)
                                                                          .update({
                                                                            'Status':
                                                                                'Paid'
                                                                          })
                                                                          .then((value) => print(
                                                                              "Loan Updated"))
                                                                          .catchError((error) =>
                                                                              print("Failed to update user: $error"));
                                                                      setState(
                                                                          () {
                                                                        pendingPaybackConfirmationsAsLoans.remove(LoanModel(
                                                                            loanFrom:
                                                                                e.value.loanFrom,
                                                                            loanTo: e.value.loanTo,
                                                                            status: e.value.status,
                                                                            amount: e.value.amount,
                                                                            tenure: e.value.tenure,
                                                                            date: e.value.date,
                                                                            approvalStatus: e.value.approvalStatus,
                                                                            id: e.value.id));
                                                                      });

                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  );
                                                                }),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                      ],
                                                    ),
                                                    buttons: [
                                                      DialogButton(
                                                        color: Colors.white,
                                                        height: 0,
                                                      ),
                                                    ]).show();
                                                //createSnackBar("Loan approved");
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList());
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBarPageName(
        pageName: "Paidback Confirmations",
        helpAlertTitle: "Loan Payback Confirmations Help",
        helpAlertBody: "Tap tick to confirm whether loan is returned.",
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
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: kPrimaryAccentColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(24))),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 10.0),
                                  child: Icon(
                                    FontAwesomeIcons.syncAlt,
                                    size: iconSize,
                                    color: kTextLightColor,
                                  )),
                              onTap: () {
                                setState(() {
                                  getUser();
                                });
                              },
                            ),
                          ],
                        ),
                      ],
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
