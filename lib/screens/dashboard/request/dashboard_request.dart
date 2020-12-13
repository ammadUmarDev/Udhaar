import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
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
import 'package:udhaar/screens/dashboard/profile/about_us.dart';
import 'package:udhaar/screens/dashboard/profile/faq_page.dart';
import 'package:udhaar/screens/dashboard/profile/settings/general_settings_screen.dart';
import 'package:udhaar/screens/dashboard/request/friends_lended.dart';
import 'package:udhaar/screens/dashboard/request/friends_owed.dart';
import 'package:udhaar/screens/dashboard/request/loan_approval_requests.dart';
import 'package:udhaar/screens/dashboard/request/pending_paidback_confirmations.dart';
import 'package:udhaar/screens/dashboard/request/request_loan.dart';
import 'package:udhaar/screens/dashboard/stats/components/grid_tile_user.dart';
import 'package:udhaar/screens/dashboard/stats/friend_manager.dart';
import 'package:udhaar/screens/dashboard/stats/search_user.dart';
import 'package:udhaar/screens/tutorial/tutorial_screen.dart';
import '../../../constants.dart';
import '../components/main_background.dart';
import '../dashboard.dart';

class DashboardRequest extends StatefulWidget {
  @override
  _DashboardRequestState createState() => _DashboardRequestState();
}

class _DashboardRequestState extends State<DashboardRequest> {
  SwiperController swiperController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget appBar = Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          ClipOval(
            child: Material(
              color: Colors.transparent, // button color
              child: InkWell(
                splashColor: kPrimaryAccentColor, // inkwell color
                child: Icon(
                  Icons.help,
                  color: kPrimaryAccentColor,
                  size: 24,
                ),
                onTap: () {
                  Alert(
                      context: context,
                      title: "Loan Request Manager Help",
                      style: AlertStyle(
                        titleStyle: H2TextStyle(color: kPrimaryAccentColor),
                      ),
                      content: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          H3(
                              textBody:
                                  "Tap to show pending loan approval requests or pending paidback confirmations."),
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
                },
              ),
            ),
          ),
          SizedBox(width: 30),
          ClipOval(
            child: Material(
              color: Colors.transparent, // button color
              child: InkWell(
                splashColor: kPrimaryAccentColor, // inkwell color
                child: Icon(
                  Icons.home,
                  color: kPrimaryAccentColor,
                  size: 24,
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return DashBoard();
                    },
                  ));
                },
              ),
            ),
          ),
        ],
      ),
    );
    Widget toLend = StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("Users").limit(3).snapshots(),
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
                                        textBody: "Tap to lend",
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
    Widget lended = StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("Users")
            .where("Email", isEqualTo: "Sdsad")
            .limit(3)
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
                                        textBody: "Tap to lend",
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
                    textBody: "Approve requests to lend money :)",
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
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.only(left: 0.0, right: 0.0),
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
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 0.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      appBar,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: cardDetails(() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => LoanApprovalRequests()));
                            },
                                'Pending Loan\nApproval Requests',
                                FontAwesomeIcons.stopwatch,
                                FontAwesomeIcons.arrowUp,
                                '1',
                                kIconColor),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: cardDetails(() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) =>
                                      PendingPaidbackConfirmations()));
                            },
                                'Pending Paidback Confirmations',
                                FontAwesomeIcons.stopwatch,
                                FontAwesomeIcons.check,
                                '0',
                                kIconColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Divider(),
                      ListTile(
                        title: Text('Request Loan'),
                        subtitle: Text('Request loan from your friends'),
                        leading: Icon(FontAwesomeIcons.moneyBillWave),
                        trailing: Icon(Icons.chevron_right,
                            color: kPrimaryLightColor),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => RequestLoan())),
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Friends Lended'),
                        subtitle: Text('View friends lended'),
                        leading: Icon(FontAwesomeIcons.userFriends),
                        trailing: Icon(Icons.chevron_right,
                            color: kPrimaryLightColor),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => FriendsLended())),
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Friends Owed'),
                        subtitle: Text('View friends you owe money'),
                        leading: Icon(FontAwesomeIcons.userTie),
                        trailing: Icon(Icons.chevron_right,
                            color: kPrimaryLightColor),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => FriendsOwed())),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget cardDetails(Function function, String title, IconData iconData1,
      IconData iconData2, String valueCount, Color icon2Color) {
    return GestureDetector(
      onTap: function,
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(7.0),
        child: Container(
          width: (MediaQuery.of(context).size.width / 2.35),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.0),
              Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: [
                      Icon(
                        iconData1,
                        size: iconSize,
                        color: kIconColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Icon(
                          iconData2,
                          size: iconSize,
                          color: icon2Color,
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(title, style: H3TextStyle(color: kTextDarkColor)),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: H2(
                  textBody: valueCount,
                  color: kPrimaryAccentColor,
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: BodyText(
                  textBody: "Approve or ignore requests",
                  color: kTextDarkColor,
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
