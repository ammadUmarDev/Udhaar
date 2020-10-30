import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:udhaar/components/body_text.dart';
import 'package:udhaar/components/h1.dart';
import 'package:udhaar/components/h2.dart';
import 'package:udhaar/constants.dart';
import 'package:udhaar/screens/dashboard/profile/faq_page.dart';
import 'package:udhaar/screens/tutorial/tutorial_screen.dart';
import '../components/main_background.dart';

class DashboardStats extends StatefulWidget {
  @override
  _DashboardStatsState createState() => _DashboardStatsState();
}

class _DashboardStatsState extends State<DashboardStats> {
  SwiperController swiperController;

  @override
  void initState() {
    super.initState();
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
                    //Comming soon alert
//                    Alert(
//                        context: context,
//                        title: "Coming Soon",
//                        style: AlertStyle(
//                          titleStyle: H2TextStyle(color: kPrimaryAccentColor),
//                        ),
//                        content: Column(
//                          children: <Widget>[
//                            SizedBox(
//                              height: 10,
//                            ),
//                            H3(textBody: "Stay tuned for the next update :)"),
//                            SizedBox(
//                              height: 10,
//                            ),
//                          ],
//                        ),
//                        buttons: [
//                          DialogButton(
//                            color: Colors.white,
//                            height: 0,
//                          ),
//                        ]).show();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => Tutorial_Screen()));
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
          Container(
            child: Row(
              children: [],
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        cardDetails('Pending Loan Approval Requests',
                            FontAwesomeIcons.moneyCheckAlt, '0'),
                        cardDetails('Pending Paidback Confirmations',
                            FontAwesomeIcons.moneyCheck, '0'),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        cardDetails('Money Lended',
                            FontAwesomeIcons.moneyBillWave, 'PKR. 0'),
                        cardDetails(
                            'Money Owed', FontAwesomeIcons.wallet, 'PKR. 0'),
                      ],
                    ),
                  ],
                )),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 5.0, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        H1(
                          textBody: "Friends Lended:",
                          color: kPrimaryAccentColor,
                        ),
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24))),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Text(
                              'View All',
                              style: TextStyle(
                                  color: kPrimaryAccentColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onTap: () {
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                builder: (context) => CategoryListScreen(),
//                              ),
//                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BodyText(
                          textBody: "Nothing to show :(",
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 5.0, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        H1(
                          textBody: "Friends Owed:",
                          color: kPrimaryAccentColor,
                        ),
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24))),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Text(
                              'View All',
                              style: TextStyle(
                                  color: kPrimaryAccentColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onTap: () {
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                builder: (context) => CategoryListScreen(),
//                              ),
//                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BodyText(
                          textBody: "Nothing to show :(",
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [],
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

  Widget cardDetails(String title, IconData iconData, String valueCount) {
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
                child: Icon(
                  iconData,
                  size: iconSize,
                  color: kIconColor,
                )),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(title,
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 15.0,
                    color: Colors.black,
                  )),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: H2(
                textBody: valueCount,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
