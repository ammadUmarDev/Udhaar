//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:rflutter_alert/rflutter_alert.dart';
//
//class Account_Settings_State extends StatefulWidget {
//  Account_Settings createState() => Account_Settings();
//}
//
//class Account_Settings extends State<Account_Settings_State> {
//  String new_user_name;
//  String new_phone_no;
//  String typeUser;
//  List<String> users = <String>[FARMER, SUPPLIER, CUSTOMER];
//  User u;
//  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//  LinearGradient mainButton = LinearGradient(
//      colors: [Color(0xFF2b580c), Color(0xFF2b580c), Color(0xFF2b580c)],
//      begin: FractionalOffset.topCenter,
//      end: FractionalOffset.bottomCenter);
//
//  List<BoxShadow> shadow = [
//    BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
//  ];
//  @override
//  Widget build(BuildContext context) {
//    u = Provider.of<General_Provider>(context, listen: false).get_user();
//    Size size = MediaQuery.of(context).size;
//    return Scaffold(
//      key: _scaffoldKey,
//      backgroundColor: Colors.white,
//      appBar: AppBarPageName(
//        pageName: "Account Settings",
//      ),
//      body: Background_S(
//        child: SafeArea(
//          child: Column(
//            children: [
//              SizedBox(
//                height: 10,
//              ),
//              ShadowBoxList(
//                icon: Icon(Icons.edit, color: kPrimaryAccentColor),
//                widgetColumn: <Widget>[
//                  SizedBox(height: 10),
//                  H2(textBody: "Full Name: " + u.fullName),
//                  SizedBox(height: 5),
//                  BodyText(textBody: "Tap to edit"),
//                  SizedBox(height: 10),
//                ],
//                onTapFunction: () {
//                  Alert(
//                      context: context,
//                      title: "Change Full Name",
//                      style: AlertStyle(
//                        titleStyle: H2TextStyle(color: kPrimaryAccentColor),
//                      ),
//                      content: Column(
//                        children: <Widget>[
//                          SizedBox(
//                            height: 10,
//                          ),
//                          RoundedInputField(
//                            hintText: "New Full Name",
//                            onChanged: (value) => {this.new_user_name = value},
//                          ),
//                          SizedBox(
//                            height: 10,
//                          ),
//                          ButtonLoading(
//                            onTap: () async {
//                              //var fire = Provider.of<General_Provider>(context, listen: false).get_firebase_user();
//                              var check =
//                                  await change_User_Name(u, new_user_name);
//                              if (check == true) {
//                                setState(() {
//                                  this.u.fullName = new_user_name;
//                                });
//                                SnackBar sc = new SnackBar(
//                                  content: Text(
//                                    "Full Name Changed Successfully",
//                                    style: TextStyle(
//                                        fontSize: 10,
//                                        fontStyle: FontStyle.italic),
//                                  ),
//                                );
//                                _scaffoldKey.currentState.showSnackBar(sc);
//                              }
//                              Navigator.pop(context);
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
//              ShadowBoxList(
//                icon: Icon(Icons.edit, color: kPrimaryAccentColor),
//                widgetColumn: <Widget>[
//                  SizedBox(height: 10),
//                  H2(textBody: "Phone No: " + u.phone_no),
//                  SizedBox(height: 5),
//                  BodyText(textBody: "Tap to edit"),
//                  SizedBox(height: 10),
//                ],
//                onTapFunction: () {
//                  Alert(
//                      context: context,
//                      title: "Change Phone Number",
//                      style: AlertStyle(
//                        titleStyle: H2TextStyle(color: kPrimaryAccentColor),
//                      ),
//                      content: Column(
//                        children: <Widget>[
//                          SizedBox(
//                            height: 10,
//                          ),
//                          RoundedInputField(
//                            hintText: "New Phone #",
//                            onChanged: (value) => {this.new_phone_no = value},
//                          ),
//                          SizedBox(
//                            height: 10,
//                          ),
//                          ButtonLoading(
//                            onTap: () async {
//                              var check =
//                                  await change_Phone_No(u, this.new_phone_no);
//                              if (check == true) {
//                                setState(() {
//                                  this.u.phone_no = this.new_phone_no;
//                                });
//                                SnackBar sc = new SnackBar(
//                                  content: Text(
//                                    "Phone No Changed Successfully",
//                                    style: TextStyle(
//                                        fontSize: 10,
//                                        fontStyle: FontStyle.italic),
//                                  ),
//                                );
//                                _scaffoldKey.currentState.showSnackBar(sc);
//                              }
//                              Navigator.pop(context);
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
//              ShadowBoxList(
//                icon: Icon(Icons.edit, color: kPrimaryAccentColor),
//                widgetColumn: <Widget>[
//                  SizedBox(height: 10),
//                  H2(textBody: "User Type: " + u.usertype),
//                  SizedBox(height: 5),
//                  BodyText(textBody: "Tap to edit"),
//                  SizedBox(height: 10),
//                ],
//                onTapFunction: () {
//                  Alert(
//                      context: context,
//                      title: "Change Account Type",
//                      style: AlertStyle(
//                        titleStyle: H2TextStyle(color: kPrimaryAccentColor),
//                      ),
//                      content: Column(
//                        children: <Widget>[
//                          SizedBox(
//                            height: 10,
//                          ),
//                          RoundedDropDown(
//                            name: "Account Type",
//                            size: size,
//                            text: typeUser,
//                            value: typeUser,
//                            onChanged: (String value) {
//                              setState(() {
//                                typeUser = value;
//                              });
//                            },
//                            items: users,
//                            icon: Icons.departure_board,
//                          ),
//                          SizedBox(
//                            height: 10,
//                          ),
//                          ButtonLoading(
//                            onTap: () async {
//                              User u = Provider.of<General_Provider>(context,
//                                      listen: false)
//                                  .get_user();
//                              if (u.cnic.length != 15) {
//                                Alert(
//                                    context: context,
//                                    title: "Invalid CNIC",
//                                    style: AlertStyle(
//                                      titleStyle: H2TextStyle(
//                                          color: kPrimaryAccentColor),
//                                    ),
//                                    content: Column(
//                                      children: <Widget>[
//                                        SizedBox(
//                                          height: 10,
//                                        ),
//                                        ButtonLoading(
//                                          onTap: () async {
//                                            Navigator.pop(context);
//                                          },
//                                          labelText: 'OK',
//                                        ),
//                                        SizedBox(
//                                          height: 10,
//                                        ),
//                                      ],
//                                    ),
//                                    buttons: [
//                                      DialogButton(
//                                        color: Colors.white,
//                                        height: 0,
//                                      ),
//                                    ]).show();
//                              } else {
//                                if (u.fullName == null ||
//                                    u.cnic == null ||
//                                    u.pass == null ||
//                                    typeUser == null ||
//                                    u.phone_no == null) {
//                                  Alert(
//                                      context: context,
//                                      title: "Please fill all fields",
//                                      style: AlertStyle(
//                                        titleStyle: H2TextStyle(
//                                            color: kPrimaryAccentColor),
//                                      ),
//                                      content: Column(
//                                        children: <Widget>[
//                                          SizedBox(
//                                            height: 10,
//                                          ),
//                                          ButtonLoading(
//                                            onTap: () async {
//                                              Navigator.pop(context);
//                                            },
//                                            labelText: 'OK',
//                                          ),
//                                          SizedBox(
//                                            height: 10,
//                                          ),
//                                        ],
//                                      ),
//                                      buttons: [
//                                        DialogButton(
//                                          color: Colors.white,
//                                          height: 0,
//                                        ),
//                                      ]).show();
//                                } else {
//                                  Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                      builder: (context) =>
//                                          Change_User_Type_FollowUp_State(
//                                        fullName: u.fullName.trim(),
//                                        cnic: u.cnic.trim(),
//                                        password: u.pass.trim(),
//                                        userType: typeUser.trim(),
//                                        phone_no: u.phone_no.trim(),
//                                      ),
//                                    ),
//                                  );
//                                }
//                              }
//                            },
//                            labelText: 'Update',
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
//  }
//}
