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
  String userImagePath;

  @override
  Widget build(BuildContext context) {
    //TODO: fix query, fix remove a friend
    Widget myFriends = StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("Users")
            .where("Email", isEqualTo: "sdasds")
            .limit(2)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

              var totalUserCount = 0;
              List<DocumentSnapshot> userDocs;

              if (snapshot.hasData) {
                userDocs = snapshot.data.docs;
                totalUserCount = userDocs.length;

                if (totalUserCount > 0) {
                  return GridView.builder(
                      itemCount: totalUserCount,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        if (userDocs[index].data()["Email"] !=
                            Provider.of<General_Provider>(context,
                                    listen: false)
                                .user
                                .email) {
                          UserModel tempObj = UserModel(
                            email: userDocs[index].data()["Email"].toString(),
                            fullName:
                                userDocs[index].data()["Full_Name"].toString(),
                            userID:
                                userDocs[index].data()["User_Id"].toString(),
                            createdDate: userDocs[index]
                                .data()["Created_Date"]
                                .toString(),
                            lastPassChangeDate: userDocs[index]
                                .data()["Last_Pass_Change_Date"]
                                .toString(),
                            friendList: userDocs[index]
                                .data()["Friend_List"]
                                .split(","),
                          );
                          return Center(
                            child: Card(
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: () {
                                  print('Tapped on user.');
                                  Alert(
                                      context: context,
                                      title: "Request a Loan From " +
                                          tempObj.fullName,
                                      style: AlertStyle(
                                        titleStyle: H2TextStyle(
                                            color: kPrimaryAccentColor),
                                      ),
                                      content: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 10,
                                          ),
                                          RoundedInputField(
                                            hintText: "Amount:",
                                            icon: FontAwesomeIcons.piggyBank,
                                          ),
                                          RoundedInputField(
                                            hintText: "Tenure:",
                                            icon: FontAwesomeIcons.businessTime,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              RoundedButton(
                                                text: "Cancel",
                                                textColor: kTextDarkColor,
                                                press: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ButtonLoading(
                                                labelText: "Confirm",
                                                onTap: () async {
                                                  Provider.of<General_Provider>(
                                                          context,
                                                          listen: false)
                                                      .user
                                                      .friendList
                                                      .add(tempObj.email);
                                                  FirebaseFirestore db =
                                                      FirebaseFirestore
                                                          .instance;
                                                  CollectionReference users =
                                                      db.collection('Users');
                                                  bool checkUpdateFriendList =
                                                      false;
                                                  await users
                                                      .doc(Provider.of<
                                                                  General_Provider>(
                                                              context,
                                                              listen: false)
                                                          .firebaseUser
                                                          .uid)
                                                      .update({
                                                        'Friend_List': Provider
                                                                .of<General_Provider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                            .user
                                                            .friendList
                                                            .join(",")
                                                      })
                                                      .then((value) =>
                                                          checkUpdateFriendList =
                                                              true)
                                                      .catchError((error) => print(
                                                          "Failed to update user: $error"));
                                                  if (checkUpdateFriendList ==
                                                      true) {
                                                    print(
                                                        "User added to friendlist");
                                                    Navigator.pop(context);
                                                  }
                                                },
                                              ),
                                            ],
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
                                child: Container(
                                  child: GridTileUser(
                                    userObj: tempObj,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return InkWell(
                            onTap: () async {},
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Icon(
                                        FontAwesomeIcons.userPlus,
                                        color: kIconColor,
                                        size: iconSize,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      H3(textBody: "Display Name"),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      BodyText(
                                        textBody: "Tap to add friend",
                                      ),
                                    ],
                                  ),
                                )),
                          );
                        }
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
                    textBody: "Lend money from friends and check again :)",
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
                    textBody: "All users fetched.",
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
                    textBody: "No users found :(",
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
        helpAlertBody: "Tap to check details of loan taken.",
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
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
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kPrimaryAccentColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: H3(
                                textBody: "Zubaria Ayub",
                                color: kTextLightColor),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: kPrimaryAccentColor, width: 3),
                              color: kTextLightColor),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                H3(
                                    textBody: "Amount: PKR 5000",
                                    color: kTextDarkColor),
                                SizedBox(height: 10),
                                H3(
                                    textBody: "Tenure: 5 months",
                                    color: kTextDarkColor),
                                SizedBox(height: 10),
                                H3(
                                    textBody:
                                        "Loan taken on: 9:00 PM - November 20, 2020",
                                    color: kTextDarkColor),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
