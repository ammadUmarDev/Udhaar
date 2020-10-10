//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:rflutter_alert/rflutter_alert.dart';
//import 'package:ugao/Classes/User_Model.dart';
//import 'package:ugao/Classes/firebase_functions.dart';
//import 'file:///C:/Users/Ammad/AndroidStudioProjects/udhaar/lib/providers/general_provider.dart';
//import 'package:ugao/components/appbar.dart';
//import 'package:ugao/components/body_text.dart';
//import 'package:ugao/components/button_loading.dart';
//import 'package:ugao/components/h2.dart';
//import 'package:ugao/components/rounded_password_field.dart';
//import 'package:ugao/components/shadowBoxList.dart';
//
//import '../../../constants.dart';
//import '../Components/background_setting.dart';
//
//class Security_Settings_State extends StatefulWidget {
//  Security_Settings createState() => Security_Settings();
//}
//
//class Security_Settings extends State<Security_Settings_State> {
//  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//  LinearGradient mainButton = LinearGradient(
//      colors: [Color(0xFF2b580c), Color(0xFF2b580c), Color(0xFF2b580c)],
//      begin: FractionalOffset.topCenter,
//      end: FractionalOffset.bottomCenter);
//  List<BoxShadow> shadow = [
//    BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
//  ];
//  String new_password;
//  String oldPassword;
//  User u;
//  @override
//  Widget build(BuildContext context) {
//    u = Provider.of<General_Provider>(context, listen: false).get_user();
//    return SafeArea(
//      child: Scaffold(
//        key: _scaffoldKey,
//        backgroundColor: Colors.white,
//        appBar: AppBarPageName(
//          pageName: "Change Password",
//        ),
//        body: Background_S(
//          child: Column(
//            children: [
//              SizedBox(height: 15),
//              ShadowBoxList(
//                icon: Icon(
//                  Icons.edit,
//                  color: kPrimaryAccentColor,
//                ),
//                widgetColumn: <Widget>[
//                  SizedBox(height: 10),
//                  H2(textBody: "Account Password: ********"),
//                  SizedBox(height: 5),
//                  BodyText(textBody: "Tap to edit"),
//                  SizedBox(height: 10),
//                ],
//                onTapFunction: () {
//                  Alert(
//                      context: context,
//                      title: "Change Password",
//                      style: AlertStyle(
//                        titleStyle: H2TextStyle(color: kPrimaryAccentColor),
//                      ),
//                      content: Column(
//                        children: <Widget>[
//                          SizedBox(
//                            height: 10,
//                          ),
//                          RoundedPasswordField(
//                            onChanged: (value) => {this.oldPassword = value},
//                          ),
//                          SizedBox(
//                            height: 10,
//                          ),
//                          ButtonLoading(
//                            onTap: () async {
//                              var check = await changePassword(
//                                  u, this.new_password, this.oldPassword);
//                              if (check == true) {
//                                setState(() {
//                                  this.u.pass = this.new_password;
//                                  print(u.pass);
//                                });
//                                SnackBar sc = new SnackBar(
//                                  content: Text(
//                                    "Password Change Successfully",
//                                    style: TextStyle(
//                                        fontSize: 10,
//                                        fontStyle: FontStyle.italic),
//                                  ),
//                                );
//                                Navigator.pop(context);
//                                _scaffoldKey.currentState.showSnackBar(sc);
//                              } else {
//                                Navigator.pop(context);
//                                print("Not Entered");
//                              }
//                            },
//                            labelText: 'SAVE',
//                          ),
//                          SizedBox(
//                            height: 10,
//                          ),
//                        ],
//                      ),
//                      buttons: [
//                        DialogButton(
//                          color: Colors.white,
//                          height: 0,
//                        ),
//                      ]).show();
//                },
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//    // TODO: implement build
//  }
//}
