import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:udhaar/components/body_text.dart';
import 'package:udhaar/components/h1.dart';
import 'package:udhaar/components/h2.dart';
import 'package:udhaar/components/h3.dart';
import 'package:udhaar/constants.dart';
import 'package:udhaar/models/User_Model.dart';
import 'package:udhaar/providers/general_provider.dart';
import 'package:udhaar/screens/dashboard/profile/faq_page.dart';
import 'package:udhaar/screens/dashboard/stats/friend_manager.dart';
import 'package:udhaar/screens/tutorial/tutorial_screen.dart';
import '../components/main_background.dart';

class DashboardStats extends StatefulWidget {
  @override
  _DashboardStatsState createState() => _DashboardStatsState();
}

class _DashboardStatsState extends State<DashboardStats> {
  SwiperController swiperController;
  UserModel userObj;
  @override
  void initState() {
    super.initState();
  }

  void gettUser() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(Provider.of<General_Provider>(context, listen: false)
            .firebaseUser
            .uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exist on the database');
        setState(() {
          userObj = UserModel(
            email: documentSnapshot.data()["Email"].toString(),
            fullName: documentSnapshot.data()["Full_Name"].toString(),
            userID: documentSnapshot.data()["User_Id"].toString(),
            createdDate: documentSnapshot.data()["Created_Date"].toString(),
            lastPassChangeDate:
                documentSnapshot.data()["Last_Pass_Change_Date"].toString(),
            friendList: documentSnapshot.data()["Friend_List"].split(","),
            friendsOwed: List.from(documentSnapshot.data()["Friends_Owed"]),
            pendingLoanApprovalsRequests: List.from(
                documentSnapshot.data()["Pending_Loan_Approvals_Requests"]),
            pendingPaybackConfirmations: List.from(
                documentSnapshot.data()["Pending_Payback_Confirmations"]),
            pendingLoanApprovalsRequestsCount: documentSnapshot
                .data()["Pending_Loan_Approvals_Requests_Count"],
            pendingPaybackConfirmationsCount:
                documentSnapshot.data()["Pending_Payback_Confirmations_Count"],
            totalAmountLended: documentSnapshot.data()["Total_Amount_Lended"],
            totalAmountOwed: documentSnapshot.data()["Total_Amount_Owed"],
            totalFriendsLended: documentSnapshot.data()["Total_Friends_Lended"],
            totalFriendsOwed: documentSnapshot.data()["Total_Friends_Owed"],
            totalFriends: documentSnapshot.data()["Total_Friends"],
            totalRequests: documentSnapshot.data()["Total_Requests"],
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget appBar = Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => TutorialScreen()));
                  },
                  icon: Icon(
                    FontAwesomeIcons.tv,
                    size: iconSize,
                    color: kPrimaryAccentColor,
                  )),
              IconButton(
                  onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => FaqScreen())),
                  icon: Icon(
                    FontAwesomeIcons.questionCircle,
                    size: iconSize,
                    color: kPrimaryAccentColor,
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => FriendManager())),
                    icon: Icon(
                      FontAwesomeIcons.userPlus,
                      size: iconSize,
                      color: kTextLightColor,
                    )),
              ],
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: CustomPaint(
        painter: MainBackground(),
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: appBar,
                ),
                SliverToBoxAdapter(
                    child: Column(
                  children: [
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      children: <Widget>[
//                        cardDetails(
//                            'Pending Loan Approval Requests',
//                            FontAwesomeIcons.stopwatch,
//                            FontAwesomeIcons.arrowUp,
//                            Provider.of<General_Provider>(context,
//                                    listen: false)
//                                .user
//                                .pendingLoanApprovalsRequestsCount
//                                .toString(),
//                            kIconColor),
//                        cardDetails(
//                            'Pending Paidback Confirmations',
//                            FontAwesomeIcons.stopwatch,
//                            FontAwesomeIcons.check,
//                            Provider.of<General_Provider>(context,
//                                    listen: false)
//                                .user
//                                .pendingPaybackConfirmationsCount
//                                .toString(),
//                            kIconColor),
//                      ],
//                    ),
//                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        cardDetails(
                            'Total Amount Lended',
                            FontAwesomeIcons.moneyBillWave,
                            FontAwesomeIcons.arrowUp,
                            'PKR. ' +
                                Provider.of<General_Provider>(context,
                                        listen: false)
                                    .user
                                    .totalAmountLended
                                    .toString(),
                            kIconColor),
                        cardDetails(
                            'Total Amount Owed',
                            FontAwesomeIcons.moneyBillWave,
                            FontAwesomeIcons.arrowDown,
                            'PKR. ' +
                                Provider.of<General_Provider>(context,
                                        listen: false)
                                    .user
                                    .totalAmountOwed
                                    .toString(),
                            kIconColor),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        cardDetails(
                            'Total Loans Given',
                            FontAwesomeIcons.handHoldingUsd,
                            FontAwesomeIcons.arrowUp,
                            Provider.of<General_Provider>(context,
                                    listen: false)
                                .user
                                .totalFriendsLended
                                .toString(),
                            kIconColor),
                        InkWell(
                          onTap: () async {
                            gettUser();
                            userObj.print_user();
                            setState(() {
                              Provider.of<General_Provider>(context,
                                      listen: false)
                                  .user = userObj;
                            });
                          },
                          child: cardDetails(
                              'Total Loans Taken',
                              FontAwesomeIcons.handHoldingUsd,
                              FontAwesomeIcons.arrowDown,
                              Provider.of<General_Provider>(context,
                                      listen: false)
                                  .user
                                  .totalFriendsOwed
                                  .toString(),
                              kIconColor),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                  ],
                )),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.only(left: 120),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  H3(textBody: "U", color: kTextDarkColor),
                  H3(textBody: "D", color: kTextDarkColor),
                  H3(textBody: "H", color: kTextDarkColor),
                  H3(textBody: "A", color: kTextDarkColor),
                  H3(textBody: "A", color: kTextDarkColor),
                  H3(textBody: "R", color: kTextDarkColor),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget listItem(String title, Color buttonColor, iconButton) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: buttonColor.withOpacity(0.3)),
            child: Icon(iconButton, color: buttonColor, size: 25.0),
          ),
          SizedBox(width: 25.0),
          Container(
            width: MediaQuery.of(context).size.width - 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                H1(
                  textBody: title,
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20.0)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardDetails(String title, IconData iconData1, IconData iconData2,
      String valueCount, Color icon2Color) {
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(7.0),
      child: Container(
        width: (MediaQuery.of(context).size.width / 2) - 20.0,
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
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
