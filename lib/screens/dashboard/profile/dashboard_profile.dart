import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:udhaar/components/appbar.dart';
import 'package:udhaar/components/body_text.dart';
import 'package:udhaar/components/h2.dart';
import 'package:udhaar/components/h3.dart';
import 'package:udhaar/models/User_Model.dart';
import 'package:udhaar/providers/general_provider.dart';
import 'package:udhaar/screens/dashboard/profile/settings/general_settings_screen.dart';
import 'package:udhaar/screens/dashboard/stats/friend_manager.dart';
import '../../../constants.dart';
import '../dashboard.dart';
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
    Widget appBar = Padding(
      padding: EdgeInsets.only(top: 30, bottom: 30),
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
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      Alert(
                          context: context,
                          title: "Profile Manager Help",
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
                                      "View and edit profile information, manage friends, read FAQs and learn more about us."),
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
                  ));
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
                  BodyText(
                      textBody: user == null
                          ? "Loading..."
                          : user.userID.substring(0, 10)),
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
                BodyText(textBody: user == null ? "Loading..." : "Active"),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                appBar,
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
                  title: Text('Manage Friends'),
                  subtitle: Text('Add and Remove Friends'),
                  leading: Icon(FontAwesomeIcons.userPlus),
                  trailing:
                      Icon(Icons.chevron_right, color: kPrimaryLightColor),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => FriendManager())),
                ),
                Divider(),
                ListTile(
                  title: Text('General Settings'),
                  subtitle: Text('Change account details and logout'),
                  leading: Icon(FontAwesomeIcons.userCog),
                  trailing:
                      Icon(Icons.chevron_right, color: kPrimaryLightColor),
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => SettingsScreen())),
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
