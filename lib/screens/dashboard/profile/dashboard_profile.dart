import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:udhaar/components/appbar.dart';
import 'package:udhaar/components/body_text.dart';
import 'package:udhaar/components/h2.dart';
import 'package:udhaar/components/h3.dart';
import 'package:udhaar/models/User_Model.dart';
import 'package:udhaar/providers/Firebase_Functions.dart';
import 'package:udhaar/screens/dashboard/dashboard.dart';
import 'package:udhaar/screens/dashboard/profile/settings/general_settings_screen.dart';
import '../../../constants.dart';
import '../components/main_background.dart';
import 'about_us.dart';
import 'faq_page.dart';

class DashboardProfile extends StatefulWidget {
  @override
  _DashboardProfileState createState() => _DashboardProfileState();
}

class _DashboardProfileState extends State<DashboardProfile> {
  SwiperController swiperController;
  UserModel userModelObj;
  String description = "Null";
  String userImagePath = "assets/icons/custIcon.png";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
    setState(() async {
      final FirebaseUser currentUser = _auth.currentUser;
      final currentUserId = currentUser.uid;
      getUser(currentUserId.toString()).then((user) {
        userModelObj = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget showDesciption() {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  H3(textBody: "Full Name:"),
                  SizedBox(height: 5),
                  BodyText(textBody: this.userModelObj.fullName),
                  SizedBox(height: 10),
                  H3(textBody: "Email:"),
                  SizedBox(height: 5),
                  BodyText(textBody: userModelObj.email),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                H3(textBody: "Last Password Change:"),
                SizedBox(height: 5),
                BodyText(textBody: userModelObj.lastPassChangeDate),
                SizedBox(height: 10),
                H3(textBody: "Account Status:"),
                SizedBox(height: 5),
                BodyText(textBody: "Active"),
                SizedBox(height: 10),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBarPageName(pageName: ""),
      body: CustomPaint(
        painter: MainBackground(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    maxRadius: 45,
                    backgroundImage: AssetImage(userImagePath),
                    backgroundColor: kPrimaryLightColor.withOpacity(0.5),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: H2(textBody: this.userModelObj.fullName)),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              //change to app color
                              color: kPrimaryLightColor,
                              blurRadius: 5,
                              spreadRadius: 4,
                              offset: Offset(0, 1))
                        ]),
                    child: Center(
                      child: showDesciption(),
                    ),
                  ),
                  SizedBox(height: 5),
                  ListTile(
                    title: Text('General Settings'),
                    subtitle: Text('Change account details and logout'),
                    leading: Icon(FontAwesomeIcons.userCog),
                    trailing:
                        Icon(Icons.chevron_right, color: kPrimaryLightColor),
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => About())),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('FAQ'),
                    subtitle: Text('Questions and Answer'),
                    leading: Icon(FontAwesomeIcons.solidQuestionCircle),
                    trailing:
                        Icon(Icons.chevron_right, color: kPrimaryLightColor),
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => FaqScreen())),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('About Us'),
                    subtitle: Text('Get to know Vectech'),
                    leading: Icon(FontAwesomeIcons.building),
                    trailing:
                        Icon(Icons.chevron_right, color: kPrimaryLightColor),
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => About())),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
