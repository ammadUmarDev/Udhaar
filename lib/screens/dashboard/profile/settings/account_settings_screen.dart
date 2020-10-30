import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:udhaar/components/appbar.dart';
import 'package:udhaar/components/body_text.dart';
import 'package:udhaar/components/buttonErims.dart';
import 'package:udhaar/components/button_loading.dart';
import 'package:udhaar/components/h2.dart';
import 'package:udhaar/components/h3.dart';
import 'package:udhaar/components/rounded_input_field.dart';
import 'package:udhaar/components/shadowBoxList.dart';
import 'package:udhaar/models/User_Model.dart';
import 'package:udhaar/providers/firebase_functions.dart';
import 'package:udhaar/providers/general_provider.dart';
import 'package:udhaar/screens/dashboard/profile/Components/background_setting.dart';

import '../../../../constants.dart';

class Account_Settings_State extends StatefulWidget {
  Account_Settings createState() => Account_Settings();
}

class Account_Settings extends State<Account_Settings_State> {
  String new_full_name;
  UserModel userObj;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  LinearGradient mainButton = LinearGradient(
      colors: [Color(0xFF2b580c), Color(0xFF2b580c), Color(0xFF2b580c)],
      begin: FractionalOffset.topCenter,
      end: FractionalOffset.bottomCenter);

  List<BoxShadow> shadow = [
    BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
  ];
  @override
  Widget build(BuildContext context) {
    userObj = Provider.of<General_Provider>(context, listen: false).get_user();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarPageName(
        pageName: "Account Settings",
      ),
      body: Background_S(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              ShadowBoxList(
                icon: Icon(Icons.edit, color: kIconColor),
                widgetColumn: <Widget>[
                  SizedBox(height: 10),
                  H2(textBody: "Full Name: " + userObj.fullName),
                  SizedBox(height: 5),
                  BodyText(textBody: "Tap to edit"),
                  SizedBox(height: 10),
                ],
                onTapFunction: () {
                  Alert(
                      context: context,
                      title: "Change Full Name",
                      style: AlertStyle(
                        titleStyle: H2TextStyle(color: kTextDarkColor),
                      ),
                      content: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          RoundedInputField(
                            hintText: "New Full Name",
                            onChanged: (value) => {this.new_full_name = value},
                            icon: FontAwesomeIcons.solidUser,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ButtonErims(
                            onTap: (startLoading, stopLoading, btnState) async {
                              if (btnState == ButtonState.Idle) {
                                startLoading();
                                var retChangeFullName =
                                    changeFullName(userObj, new_full_name);
                                bool retChangeFullNameCheck;
                                await retChangeFullName.then(
                                    (value) => retChangeFullNameCheck = value);
                                if (retChangeFullNameCheck == true) {
                                  setState(() {
                                    userObj.fullName = new_full_name;
                                    Provider.of<General_Provider>(context,
                                            listen: false)
                                        .set_user(userObj);
                                    SnackBar sc = SnackBar(
                                      content: Text(
                                        "Full Name Changed Successfully",
                                        style: H3TextStyle(),
                                      ),
                                    );
                                    _scaffoldKey.currentState.showSnackBar(sc);
                                    Navigator.pop(context);
                                    stopLoading();
                                  });
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
