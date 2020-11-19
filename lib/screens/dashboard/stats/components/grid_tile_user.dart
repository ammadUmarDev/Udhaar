import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:udhaar/components/body_text.dart';
import 'package:udhaar/components/h2.dart';
import 'package:udhaar/components/h3.dart';
import 'package:udhaar/components/rounded_button.dart';
import 'package:udhaar/models/User_Model.dart';

import '../../../../constants.dart';

class GridTileUser extends StatelessWidget {
  final UserModel userObj;

  GridTileUser({
    Key key,
    this.userObj,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userImagePath = "assets/icons/custIcon.png";
    return InkWell(
      child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          elevation: 0,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Icon(
                  FontAwesomeIcons.userPlus,
                  color: kPrimaryAccentColor,
                  size: iconSize,
                ),
                SizedBox(
                  height: 10,
                ),
                H3(
                  textBody: userObj.email
                      .toString()
                      .substring(0, userObj.email.indexOf("@")),
                ),
                SizedBox(
                  height: 5,
                ),
                BodyText(
                  textBody: userObj.fullName.toString(),
                ),
              ],
            ),
          )),
    );
  }
}
