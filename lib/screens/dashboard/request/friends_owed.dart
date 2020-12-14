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

class FriendsOwed extends StatefulWidget {
  @override
  _FriendsOwedState createState() => _FriendsOwedState();
}

class _FriendsOwedState extends State<FriendsOwed> {
  BuildContext scaffoldContext;
  String userImagePath;

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

    Widget owedFriends = StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("Loans")
            .where("Loan_To",
                isEqualTo: Provider.of<General_Provider>(context, listen: false)
                    .user
                    .email)
            .where("Approval_Status", isEqualTo: "Approved")
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
                                        H3(textBody: "Money owed to"),
                                        SizedBox(width: 10),
                                        H2(
                                            textBody: reqDocs[index]
                                                .data()["Loan_From"]
                                                .toString()
                                                .substring(
                                                    0,
                                                    reqDocs[index]
                                                        .data()["Loan_From"]
                                                        .toString()
                                                        .indexOf("@")),
                                            color: kPrimaryAccentColor),
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
                                              InkWell(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          kPrimaryAccentColor,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  24))),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 10.0),
                                                  child: H3(
                                                      textBody: "Payback Loan",
                                                      color: kTextLightColor),
                                                ),
                                                onTap: () {
                                                  Alert(
                                                      context: context,
                                                      title: "Payback Loan",
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
                                                                onTap:
                                                                    () async {
                                                                  setState(() {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'Loans')
                                                                        .doc(reqDocs[index]
                                                                            .id)
                                                                        .update({
                                                                          'Status':
                                                                              'Confirming Payment'
                                                                        })
                                                                        .then((value) =>
                                                                            print(
                                                                                "Loan Updated"))
                                                                        .catchError((error) =>
                                                                            print("Failed to update user: $error"));
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'Users')
                                                                        .where(
                                                                            'Email',
                                                                            isEqualTo: reqDocs[index].data()[
                                                                                "Loan_From"])
                                                                        .get()
                                                                        .then(
                                                                            (querySnapshot) {
                                                                      querySnapshot
                                                                          .docs
                                                                          .forEach(
                                                                              (documentSnapshot) {
                                                                        List<String>
                                                                            pbConfirms =
                                                                            List.from(documentSnapshot.data()["Pending_Payback_Confirmations"]);
                                                                        pbConfirms.add(reqDocs[index].data()["Loan_From"] +
                                                                            "," +
                                                                            reqDocs[index].data()["Loan_To"] +
                                                                            "," +
                                                                            reqDocs[index].data()["Status"] +
                                                                            "," +
                                                                            reqDocs[index].data()["Amount"].toString() +
                                                                            "," +
                                                                            reqDocs[index].data()["Tenure"].toString() +
                                                                            "," +
                                                                            reqDocs[index].data()["Date"] +
                                                                            "," +
                                                                            reqDocs[index].data()["Approval_Status"] +
                                                                            "," +
                                                                            reqDocs[index].id);
                                                                        int pbConfirmsCount =
                                                                            documentSnapshot.data()["Pending_Payback_Confirmations_Count"];
                                                                        pbConfirmsCount +=
                                                                            1;
                                                                        documentSnapshot
                                                                            .reference
                                                                            .update({
                                                                          'Pending_Payback_Confirmations':
                                                                              pbConfirms,
                                                                          'Pending_Payback_Confirmations_Count':
                                                                              pbConfirmsCount,
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
                                                          color: Colors.white,
                                                          height: 0,
                                                        ),
                                                      ]).show();
                                                  createSnackBar(
                                                      "Payback confirmation request sent");
                                                },
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
          pageName: "Friends Owed",
          helpAlertTitle: "Friends Owed Help",
          helpAlertBody: "View details of loans taken and payback.",
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10.0),
                  child: Column(
                    children: [
                      owedFriends,
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
