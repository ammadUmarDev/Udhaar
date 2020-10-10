//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:ugao/components/appbar.dart';
//import 'package:ugao/screens/profile/Components/background_setting.dart';
//import 'package:ugao/screens/profile/settings/account_settings_screen.dart';
//import 'package:ugao/screens/profile/settings/security_settings.dart';
//import 'package:ugao/screens/welcome/welcome_screen.dart';
//
//class SettingsScreen extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBarPageName(pageName: "General Settings"),
//      body: Background_S(
//        child: SafeArea(
//          bottom: true,
//          child: LayoutBuilder(
//              builder: (builder, constraints) => SingleChildScrollView(
//                    child: ConstrainedBox(
//                      constraints:
//                          BoxConstraints(minHeight: constraints.maxHeight),
//                      child: Padding(
//                        padding: const EdgeInsets.only(
//                            top: 24.0, left: 24.0, right: 24.0),
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            ListTile(
//                              title: Text('Account Settings'),
//                              leading: Icon(FontAwesomeIcons.userCog),
//                              onTap: () => Navigator.of(context).push(
//                                  MaterialPageRoute(
//                                      builder: (_) =>
//                                          Account_Settings_State())),
//                            ),
//                            ListTile(
//                              title: Text('Security Settings'),
//                              leading: Icon(FontAwesomeIcons.userLock),
//                              onTap: () => Navigator.of(context).push(
//                                  MaterialPageRoute(
//                                      builder: (_) =>
//                                          Security_Settings_State())),
//                            ),
//                            ListTile(
//                                title: Text('Sign out'),
//                                leading: Icon(FontAwesomeIcons.signOutAlt),
//                                onTap: () {
//                                  FirebaseAuth.instance.signOut();
//                                  Navigator.of(context).push(MaterialPageRoute(
//                                      builder: (_) => WelcomeScreen()));
//                                }),
//                          ],
//                        ),
//                      ),
//                    ),
//                  )),
//        ),
//      ),
//    );
//  }
//}
