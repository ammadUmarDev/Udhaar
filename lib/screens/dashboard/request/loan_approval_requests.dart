import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:udhaar/models/User_Model.dart';
import 'package:udhaar/providers/general_provider.dart';
import 'package:udhaar/screens/dashboard/stats/components/grid_tile_user.dart';
import 'package:udhaar/screens/dashboard/stats/search_user.dart';
import '../../../constants.dart';

class LoanApprovalRequests extends StatefulWidget {
  @override
  _LoanApprovalRequestsState createState() => _LoanApprovalRequestsState();
}

class _LoanApprovalRequestsState extends State<LoanApprovalRequests> {
  BuildContext scaffoldContext;
  String userImagePath;
  List<String> Pending_Loan_Approvals_Requests;
  @override
  Future<void> initState() {
    getUser();
  }

  void getUser() async {
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
                  .pendingLoanApprovalsRequests =
              retGetUserObjFirebase.pendingLoanApprovalsRequests;
          Pending_Loan_Approvals_Requests =
              retGetUserObjFirebase.pendingLoanApprovalsRequests;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    void createSnackBar(String message) {
      final snackBar = new SnackBar(
          content: new BodyText(
            textBody: message,
            color: kTextLightColor,
          ),
          backgroundColor: kTextDarkColor);

      // Find the Scaffold in the Widget tree and use it to show a SnackBar!
      Scaffold.of(scaffoldContext).showSnackBar(snackBar);
    }

    Widget myFriends = StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("Loans")
            .where("Loan_From",
                isEqualTo: Provider.of<General_Provider>(context, listen: false)
                    .user
                    .email)
            .where("Approval_Status", isEqualTo: "Unapproved")
            .where("Status", isEqualTo: "Unpaid")
            .snapshots(),
        builder:
            (BuildContext ccontext, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                ),
                H3(
                  textBody: "Error in fetching users: ${snapshot.error}.",
                )
              ],
            ));
          }

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                  ),
                  H3(
                    textBody: "Not connected to the Stream or null.",
                  )
                ],
              ));

            case ConnectionState.waiting:
              return Center(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                  ),
                  H3(
                    textBody: "Awaiting for interaction.",
                  )
                ],
              ));

            case ConnectionState.active:
              print("Stream has started but not finished");

              var totalReqCount = 0;
              List<DocumentSnapshot> reqDocs;

              if (snapshot.hasData) {
                reqDocs = snapshot.data.docs;
                totalReqCount = reqDocs.length;
                print(totalReqCount);

                if (totalReqCount > 0) {
                  return GridView.builder(
                      itemCount: totalReqCount,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1, mainAxisSpacing: 1),
                      itemBuilder: (BuildContext ccontext, int index) {
                        return Column(
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
                                        H2(
                                            textBody: reqDocs[index]
                                                .data()["Loan_To"]
                                                .toString()
                                                .substring(
                                                    0,
                                                    reqDocs[index]
                                                        .data()["Loan_To"]
                                                        .toString()
                                                        .indexOf("@")),
                                            color: kPrimaryAccentColor),
                                        SizedBox(width: 10),
                                        H3(textBody: "wants to request a loan"),
                                      ],
                                    ),
                                  ),
                                  Container(
//                                          decoration: BoxDecoration(
//                                            border: Border(
//                                                color: kPrimaryAccentColor
//                                                    .withOpacity(0.2),
//                                                width: 2),
//                                            color: kTextLightColor),
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              BodyText(
                                                  textBody: "•  Amount: PKR " +
                                                      reqDocs[index]
                                                          .data()["Amount"]
                                                          .toString(),
                                                  color: kTextDarkColor),
                                              SizedBox(height: 5),
                                              BodyText(
                                                  textBody: "•  Tenure: " +
                                                      reqDocs[index]
                                                          .data()["Tenure"]
                                                          .toString() +
                                                      " months",
                                                  color: kTextDarkColor),
                                              SizedBox(height: 5),
                                              BodyText(
                                                  textBody: "•  Approval Status: " +
                                                      reqDocs[index]
                                                          .data()[
                                                              "Approval_Status"]
                                                          .toString(),
                                                  color: kTextDarkColor),
                                              SizedBox(height: 5),
                                              BodyText(
                                                  textBody:
                                                      "•  Payback Status: Unavailable",
                                                  color: kTextDarkColor),
                                              SizedBox(height: 5),
                                              BodyText(
                                                  textBody:
                                                      "•  Requested Date: " +
                                                          reqDocs[index]
                                                              .data()["Date"]
                                                              .toString(),
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
                                                        color:
                                                            kPrimaryAccentColor,
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
                                                                    text:
                                                                        "Cancel",
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
                                                                            .doc(reqDocs[index]
                                                                                .id)
                                                                            .update({
                                                                              'Approval_Status': 'Approved'
                                                                            })
                                                                            .then((value) =>
                                                                                print("Loan Updated"))
                                                                            .catchError((error) => print("Failed to update user: $error"));
                                                                        Provider.of<General_Provider>(context,
                                                                                listen: false)
                                                                            .user
                                                                            .totalFriendsLended += 1;
                                                                        Provider.of<General_Provider>(context, listen: false)
                                                                            .user
                                                                            .totalAmountLended += reqDocs[index]
                                                                                .data()[
                                                                            "Amount"];
                                                                        Provider.of<General_Provider>(context,
                                                                                listen: false)
                                                                            .user
                                                                            .friendsLended
                                                                            .add(reqDocs[index].data()["Loan_To"]);
                                                                        Provider.of<General_Provider>(context,
                                                                                listen: false)
                                                                            .user
                                                                            .pendingLoanApprovalsRequestsCount -= 1;
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                                'Users')
                                                                            .doc(Provider.of<General_Provider>(context, listen: false)
                                                                                .user
                                                                                .userID)
                                                                            .update({
                                                                              'Friends_Lended': Provider.of<General_Provider>(context, listen: false).user.friendsLended,
                                                                              'Total_Amount_Lended': Provider.of<General_Provider>(context, listen: false).user.totalAmountLended,
                                                                              'Total_Friends_Lended': Provider.of<General_Provider>(context, listen: false).user.totalFriendsLended,
                                                                              'Pending_Loan_Approvals_Requests_Count': Provider.of<General_Provider>(context, listen: false).user.pendingLoanApprovalsRequestsCount,
                                                                            })
                                                                            .then((value) =>
                                                                                print("User Updated"))
                                                                            .catchError((error) => print("Failed to update user: $error"));
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                                'Users')
                                                                            .where('Email',
                                                                                isEqualTo: reqDocs[index].data()["Loan_To"])
                                                                            .get()
                                                                            .then((querySnapshot) {
                                                                          querySnapshot
                                                                              .docs
                                                                              .forEach((documentSnapshot) {
                                                                            List<String>
                                                                                owedFList =
                                                                                List.from(documentSnapshot.data()["Friends_Owed"]);
                                                                            owedFList.add(reqDocs[index].data()["Loan_From"]);
                                                                            double
                                                                                tAowed =
                                                                                documentSnapshot.data()["Total_Amount_Owed"];
                                                                            tAowed +=
                                                                                reqDocs[index].data()["Amount"];
                                                                            int tFowed =
                                                                                documentSnapshot.data()["Total_Friends_Owed"];
                                                                            tFowed +=
                                                                                1;
                                                                            documentSnapshot.reference.update({
                                                                              'Friends_Owed': owedFList,
                                                                              'Total_Amount_Owed': tAowed,
                                                                              'Total_Friends_Owed': tFowed,
                                                                            });
                                                                          });
                                                                        });
                                                                      });

                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                            ],
                                                          ),
                                                          buttons: [
                                                            DialogButton(
                                                              color:
                                                                  Colors.white,
                                                              height: 0,
                                                            ),
                                                          ]).show();
                                                      createSnackBar(
                                                          "Loan approved");
                                                    },
                                                  ),
                                                ),
                                              ),
                                              ClipOval(
                                                child: Material(
                                                  color: Colors
                                                      .transparent, // button color
                                                  child: InkWell(
                                                    splashColor:
                                                        kPrimaryAccentColor, // inkwell color
                                                    child: SizedBox(
                                                      width: 50,
                                                      height: 50,
                                                      child: Icon(
                                                        Icons.clear,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      Alert(
                                                          context: context,
                                                          title: "Reject Loan",
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
                                                                    text:
                                                                        "Cancel",
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
                                                                    onTap:
                                                                        () async {
                                                                      await FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'Loans')
                                                                          .doc(reqDocs[index]
                                                                              .id)
                                                                          .update({
                                                                            'Approval_Status':
                                                                                'Rejected'
                                                                          })
                                                                          .then((value) => print(
                                                                              "User Updated"))
                                                                          .catchError((error) =>
                                                                              print("Failed to update user: $error"));
                                                                      await FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'Users')
                                                                          .where(
                                                                              'Email',
                                                                              isEqualTo: reqDocs[index].data()["Loan_To"])
                                                                          .get()
                                                                          .then((querySnapshot) {
                                                                        querySnapshot
                                                                            .docs
                                                                            .forEach((documentSnapshot) {
                                                                          int count =
                                                                              documentSnapshot.data()["Pending_Loan_Approvals_Requests_Count"];
                                                                          count -=
                                                                              1;
                                                                          documentSnapshot
                                                                              .reference
                                                                              .update({
                                                                            'Pending_Loan_Approvals_Requests_Count':
                                                                                count,
                                                                          });
                                                                        });
                                                                      });
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                            ],
                                                          ),
                                                          buttons: [
                                                            DialogButton(
                                                              color:
                                                                  Colors.white,
                                                              height: 0,
                                                            ),
                                                          ]).show();
                                                      createSnackBar(
                                                          "Loan rejected");
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
                        );
                      });
                }
              }
              return Center(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                  ),
                  H3(
                    textBody: "No requests found :(",
                  )
                ],
              ));

            case ConnectionState.done:
              return Center(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                  ),
                  H3(
                    textBody: "All requests fetched.",
                  )
                ],
              ));
          }

          return Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                  ),
                  H3(
                    textBody: "No requests found :(",
                  )
                ],
              ),
            ),
          );
        });

    return Scaffold(
        backgroundColor: Color(0xffF9F9F9),
        appBar: AppBarPageName(
          pageName: "Loan Approval Requests",
          helpAlertTitle: "Loan Approval Requests Help",
          helpAlertBody: "Approve or reject loan requests.",
        ),
        body: Builder(builder: (BuildContext context) {
          scaffoldContext = context;
          return SafeArea(
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
                  child: myFriends,
                ),
              ),
            ),
          );
        }));
  }
}
