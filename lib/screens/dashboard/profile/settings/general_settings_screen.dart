import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:udhaar/components/appbar.dart';
import 'package:udhaar/screens/authentication_handler/RegisterPage.dart';
import 'package:udhaar/screens/dashboard/profile/Components/background_setting.dart';
import 'package:udhaar/screens/dashboard/profile/settings/account_settings_screen.dart';
import 'package:udhaar/screens/dashboard/profile/settings/security_settings.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPageName(pageName: "General Settings"),
      body: BackgroundS(
        child: SafeArea(
          bottom: true,
          child: LayoutBuilder(
              builder: (builder, constraints) => SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 24.0, left: 24.0, right: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Text('Account Settings'),
                              leading: Icon(FontAwesomeIcons.userCog),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => AccountSettingsState())),
                            ),
                            ListTile(
                              title: Text('Security Settings'),
                              leading: Icon(FontAwesomeIcons.userLock),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => SecuritySettingsState())),
                            ),
                            ListTile(
                                title: Text('Sign out'),
                                leading: Icon(FontAwesomeIcons.signOutAlt),
                                onTap: () {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => RegisterPage()));
                                }),
                          ],
                        ),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
