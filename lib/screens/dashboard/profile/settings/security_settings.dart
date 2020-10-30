import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:udhaar/components/appbar.dart';
import 'package:udhaar/components/body_text.dart';
import 'package:udhaar/components/buttonErims.dart';
import 'package:udhaar/components/h2.dart';
import 'package:udhaar/components/h3.dart';
import 'package:udhaar/components/rounded_password_field.dart';
import 'package:udhaar/components/shadowBoxList.dart';
import 'package:udhaar/constants.dart';
import 'package:udhaar/models/User_Model.dart';
import 'package:udhaar/providers/firebase_functions.dart';
import 'package:udhaar/providers/general_provider.dart';
import '../Components/background_setting.dart';

class Security_Settings_State extends StatefulWidget {
  Security_Settings createState() => Security_Settings();
}

class Security_Settings extends State<Security_Settings_State> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  LinearGradient mainButton = LinearGradient(
      colors: [Color(0xFF2b580c), Color(0xFF2b580c), Color(0xFF2b580c)],
      begin: FractionalOffset.topCenter,
      end: FractionalOffset.bottomCenter);
  List<BoxShadow> shadow = [
    BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
  ];
  String new_password;
  String oldPassword;
  UserModel u;
  @override
  Widget build(BuildContext context) {
    u = Provider.of<General_Provider>(context, listen: false).get_user();
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBarPageName(
          pageName: "Change Password",
        ),
        body: Background_S(
          child: Column(
            children: [
              SizedBox(height: 15),
              ShadowBoxList(
                icon: Icon(
                  Icons.edit,
                  color: kPrimaryAccentColor,
                ),
                widgetColumn: <Widget>[
                  SizedBox(height: 10),
                  H2(textBody: "Account Password: *********"),
                  SizedBox(height: 5),
                  BodyText(textBody: "Last Change: " + u.createdDate),
                  SizedBox(height: 5),
                  BodyText(textBody: "Tap to edit"),
                  SizedBox(height: 10),
                ],
                onTapFunction: () {
                  Alert(
                      context: context,
                      title: "Change Password",
                      style: AlertStyle(
                        titleStyle: H2TextStyle(color: kTextDarkColor),
                      ),
                      content: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          RoundedPasswordField(
                            onChanged: (value) => {this.oldPassword = value},
                            hintText: "Old Password",
                          ),
                          RoundedPasswordField(
                            onChanged: (value) => {this.new_password = value},
                            hintText: "New Password",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ButtonErims(
                            onTap: (startLoading, stopLoading, btnState) async {
                              if (btnState == ButtonState.Idle) {
                                startLoading();
                                try {
                                  EmailAuthCredential credential =
                                      EmailAuthProvider.credential(
                                          email: u.email,
                                          password: oldPassword);
                                  await FirebaseAuth.instance.currentUser
                                      .reauthenticateWithCredential(credential);
                                  try {
                                    await changePassword(u, new_password)
                                        .then((value) => () {
                                              if (value == true) {
                                                setState(() {
                                                  SnackBar sc = SnackBar(
                                                    content: Text(
                                                      "Password Changed Successfully",
                                                      style: H3TextStyle(),
                                                    ),
                                                  );
                                                  _scaffoldKey.currentState
                                                      .showSnackBar(sc);
                                                  Navigator.pop(context);
                                                  stopLoading();
                                                });
                                              } else {
                                                Alert(
                                                  context: context,
                                                  title:
                                                      "Something Went Wrong :(",
                                                  style: AlertStyle(
                                                    titleStyle: H2TextStyle(
                                                        color: kTextDarkColor),
                                                  ),
                                                  content: Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      H3(
                                                          textBody:
                                                              "Please enter correct old password."),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            });
                                  } catch (e) {
                                    print(e);
                                    Alert(
                                      context: context,
                                      title: "Something Went Wrong :(",
                                      style: AlertStyle(
                                        titleStyle:
                                            H2TextStyle(color: kTextDarkColor),
                                      ),
                                      content: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 10,
                                          ),
                                          H3(
                                              textBody:
                                                  "Please enter correct old password."),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  print(e);
                                  Alert(
                                    context: context,
                                    title: "Something Went Wrong :(",
                                    style: AlertStyle(
                                      titleStyle:
                                          H2TextStyle(color: kTextDarkColor),
                                    ),
                                    content: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 10,
                                        ),
                                        H3(
                                            textBody:
                                                "Please enter correct old password."),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              } else {
                                stopLoading();
                              }
                            },
                            labelText: "SAVE",
                          ),
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
            ],
          ),
        ),
      ),
    );
  }
}
