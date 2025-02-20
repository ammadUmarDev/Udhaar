import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:udhaar/components/body_text.dart';
import 'package:udhaar/components/h3.dart';
import 'package:udhaar/constants.dart';
import 'package:udhaar/screens/dashboard/profile/dashboard_profile.dart';
import 'package:udhaar/screens/dashboard/request/dashboard_request.dart';
import 'stats/dashboard_stats.dart';

class DashBoard extends StatefulWidget {
  static final String id = 'dashBoard';

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: buildHomeScreen(),
    );
  }

  Scaffold buildHomeScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          DashboardStats(),
          DashboardRequest(),
          DashboardProfile(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        scrollDirection: Axis.horizontal,
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: kPrimaryAccentColor,
        inactiveColor: kPrimaryLightColor.withOpacity(0.7),
        items: [
          BottomNavigationBarItem(
            title: BodyText(
              textBody: "Statistics",
            ),
            icon: Icon(
              FontAwesomeIcons.piggyBank,
              size: iconSize,
            ),
          ),
          BottomNavigationBarItem(
            title: BodyText(
              textBody: "Requests",
            ),
            icon: Icon(
              FontAwesomeIcons.moneyCheckAlt,
              size: iconSize,
            ),
          ),
          BottomNavigationBarItem(
            title: BodyText(
              textBody: "Profile",
            ),
            icon: Icon(
              FontAwesomeIcons.solidUser,
              size: iconSize,
            ),
          ),
        ],
      ),
    );
  }
}
