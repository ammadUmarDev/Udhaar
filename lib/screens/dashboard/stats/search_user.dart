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
import 'package:udhaar/components/text_Field_outlined.dart';
import 'package:udhaar/models/User_Model.dart';
import 'package:udhaar/providers/general_provider.dart';
import 'package:udhaar/screens/dashboard/stats/components/grid_tile_user.dart';
import '../../../constants.dart';

class SearchFriend extends StatefulWidget {
  @override
  _SearchFriendState createState() => _SearchFriendState();
}

class _SearchFriendState extends State<SearchFriend> {
  String userImagePath;
  String searchQuery = "";

  TextFieldOutlined emailTextField = TextFieldOutlined(
    textFieldText: 'Email (example@gmail.com)',
    textFieldIcon: Icon(
      FontAwesomeIcons.solidEnvelopeOpen,
      size: iconSize,
      color: kIconColor,
    ),
    keyboardType: TextInputType.emailAddress,
    isValidEntry: (entry) {
      if (entry.toString().contains('@') && entry.toString().endsWith('.com'))
        return '';
      return 'Invalid Email';
    },
    onChanged: () {},
  );

  @override
  Widget build(BuildContext context) {
    Widget exploreUsers = StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("Users")
            .where("Email", isEqualTo: searchQuery)
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
                  return new GridView.builder(
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
                                      title: "Add " +
                                          tempObj.fullName +
                                          " as Friend?",
                                      style: AlertStyle(
                                        titleStyle: H2TextStyle(
                                            color: kPrimaryAccentColor),
                                      ),
                                      content: Column(
                                        children: <Widget>[
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
                    textBody: "No users found :(",
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
        pageName: "Search Friends",
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
              child: ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      H1(
                        textBody: "Search by Email",
                        color: kPrimaryAccentColor,
                      ),
                      InkWell(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24))),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Icon(
                              FontAwesomeIcons.search,
                              size: iconSize,
                              color: kPrimaryAccentColor,
                            )),
                        onTap: () {
                          setState(() {
                            searchQuery = emailTextField.retValue.toString();
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  emailTextField,
                  SizedBox(height: 20),
                  exploreUsers,
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
