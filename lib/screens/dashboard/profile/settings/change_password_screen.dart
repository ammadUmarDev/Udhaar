//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:ugao/components/button_loading.dart';
//import 'package:ugao/components/rounded_button.dart';
//
//class ChangePasswordScreen extends StatefulWidget {
//  @override
//  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
//}
//
//class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//  @override
//  Widget build(BuildContext context) {
//    double width = MediaQuery.of(context).size.width;
//    double bottomPadding = MediaQuery.of(context).padding.bottom;
//
//    return Scaffold(
//      backgroundColor: Colors.grey[100],
//      appBar: AppBar(
//        iconTheme: IconThemeData(
//          color: Colors.black,
//        ),
//        brightness: Brightness.light,
//        backgroundColor: Colors.transparent,
//        title: Text(
//          'Settings',
//          style: TextStyle(color: Colors.black45),
//        ),
//        elevation: 0,
//      ),
//      body: SafeArea(
//          bottom: true,
//          child: LayoutBuilder(
//            builder: (b, constraints) => Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 16.0),
//              child: SingleChildScrollView(
//                child: ConstrainedBox(
//                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Padding(
//                            padding:
//                                const EdgeInsets.only(bottom: 48.0, top: 16.0),
//                            child: Text(
//                              'Change Password',
//                              style: TextStyle(
//                                  color: Colors.black,
//                                  fontWeight: FontWeight.bold,
//                                  fontSize: 18.0),
//                            ),
//                          ),
//                          Padding(
//                            padding: const EdgeInsets.only(bottom: 12.0),
//                            child: Text(
//                              'Enter your current password',
//                              style: TextStyle(fontWeight: FontWeight.bold),
//                            ),
//                          ),
//                          Container(
//                              padding: const EdgeInsets.symmetric(
//                                  horizontal: 16.0, vertical: 8.0),
//                              decoration: BoxDecoration(
//                                  color: Colors.white,
//                                  borderRadius:
//                                      BorderRadius.all(Radius.circular(5))),
//                              child: TextField(
//                                decoration: InputDecoration(
//                                    border: InputBorder.none,
//                                    hintText: 'Existing Password',
//                                    hintStyle: TextStyle(fontSize: 12.0)),
//                              )),
//                          Padding(
//                            padding:
//                                const EdgeInsets.only(top: 24, bottom: 12.0),
//                            child: Text(
//                              'Enter new password',
//                              style: TextStyle(fontWeight: FontWeight.bold),
//                            ),
//                          ),
//                          Container(
//                              padding: const EdgeInsets.symmetric(
//                                  horizontal: 16.0, vertical: 8.0),
//                              decoration: BoxDecoration(
//                                  color: Colors.white,
//                                  borderRadius:
//                                      BorderRadius.all(Radius.circular(5))),
//                              child: TextField(
//                                decoration: InputDecoration(
//                                    border: InputBorder.none,
//                                    hintText: 'New Password',
//                                    hintStyle: TextStyle(fontSize: 12.0)),
//                              )),
//                          Padding(
//                            padding:
//                                const EdgeInsets.only(top: 24, bottom: 12.0),
//                            child: Text(
//                              'Retype new password',
//                              style: TextStyle(fontWeight: FontWeight.bold),
//                            ),
//                          ),
//                          Container(
//                              padding: const EdgeInsets.symmetric(
//                                  horizontal: 16.0, vertical: 8.0),
//                              decoration: BoxDecoration(
//                                  color: Colors.white,
//                                  borderRadius:
//                                      BorderRadius.all(Radius.circular(5))),
//                              child: TextField(
//                                decoration: InputDecoration(
//                                    border: InputBorder.none,
//                                    hintText: 'Retype Password',
//                                    hintStyle: TextStyle(fontSize: 12.0)),
//                              )),
//                        ],
//                      ),
//                      Align(
//                        alignment: Alignment.bottomCenter,
//                        child: Container(
//                          padding: EdgeInsets.only(
//                              top: 8.0,
//                              bottom: bottomPadding != 20 ? 20 : bottomPadding),
//                          width: width,
//                          child: Center(
//                            child: ButtonLoading(
//                              labelText: "Change Password",
//                              onTap: () {
//                                //TODO: implement change password functionality
//                              },
//                            ),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          )),
//    );
//  }
//}
