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

class RequestLoan extends StatefulWidget {
  @override
  _RequestLoanState createState() => _RequestLoanState();
}

class _RequestLoanState extends State<RequestLoan> {
  String userImagePath;
  List<String> friendsList;
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
        );
        setState(() {
          Provider.of<General_Provider>(context, listen: false)
              .user
              .friendList = retGetUserObjFirebase.friendList;
          friendsList = retGetUserObjFirebase.friendList;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget friends = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: Provider.of<General_Provider>(context, listen: false)
            .user
            .friendList
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
        pageName: "Request Loan",
        helpAlertTitle: "Request Loan Help",
        helpAlertBody: "Tap to request a loan from list of friends.",
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
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
              child: ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      H1(
                        textBody: "My Friends",
                        color: kPrimaryAccentColor,
                      ),
                      InkWell(
                        child: Container(
                            decoration: BoxDecoration(
                                color: kPrimaryAccentColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24))),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 10.0),
                            child: Icon(
                              FontAwesomeIcons.syncAlt,
                              size: iconSize,
                              color: kTextLightColor,
                            )),
                        onTap: () {
                          setState(() async {
                            await getUser();
                          });
                        },
                      ),
                    ],
                  ),
                  BodyText(
                    textBody: "Reload to update friend list",
                    color: kTextDarkColor,
                  ),
                  SizedBox(height: 10),
                  friends,
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
