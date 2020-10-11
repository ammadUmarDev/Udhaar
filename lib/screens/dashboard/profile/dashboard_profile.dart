import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:udhaar/components/appbar.dart';
import 'package:udhaar/components/body_text.dart';
import 'package:udhaar/components/h2.dart';
import 'package:udhaar/components/h3.dart';
import 'package:udhaar/models/User_Model.dart';
import 'package:udhaar/providers/general_provider.dart';
import '../../../constants.dart';
import '../components/main_background.dart';
import 'about_us.dart';
import 'faq_page.dart';

class DashboardProfile extends StatefulWidget {
  @override
  _DashboardProfileState createState() => _DashboardProfileState();
}

class _DashboardProfileState extends State<DashboardProfile> {
  UserModel user;
  String description = "Null";
  String userImagePath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = Provider.of<General_Provider>(context, listen: false).get_user();
    if (user == null) {
      print("user obj is null");
    }
  }

  @override
  Widget build(BuildContext context) {
    userImagePath = "assets/icons/custIcon.png";
    user = Provider.of<General_Provider>(context, listen: false).get_user();
    // ignore: missing_return
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
                  H3(textBody: "User ID:"),
                  SizedBox(height: 5),
                  BodyText(textBody: user == null ? "Loading..." : user.userID),
                  SizedBox(height: 10),
                  H3(textBody: "Email:"),
                  SizedBox(height: 5),
                  BodyText(textBody: user == null ? "Loading..." : user.email),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                H3(textBody: "Joined On:"),
                SizedBox(height: 5),
                BodyText(
                    textBody: user == null ? "Loading..." : user.createdDate),
                SizedBox(height: 10),
                H3(textBody: "Pass Changed On:"),
                SizedBox(height: 5),
                BodyText(
                    textBody:
                        user == null ? "Loading..." : user.lastPassChangeDate),
                SizedBox(height: 10),
                H3(textBody: "Account Status:"),
                SizedBox(height: 5),
                BodyText(textBody: "Loading..."),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBarPageName(pageName: ""),
      body: SafeArea(
        top: true,
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
                    child: H2(
                        textBody: user == null ? "Loading..." : user.fullName)),
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
//                  onTap: () => Navigator.of(context).push(
//                      MaterialPageRoute(builder: (_) => SettingsScreen())),
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
    );
  }
}
