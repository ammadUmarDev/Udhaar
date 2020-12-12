import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../constants.dart';
import '../screens/dashboard/dashboard.dart';
import 'h1.dart';
import 'h2.dart';
import 'h3.dart';

class AppBarPageName extends StatelessWidget implements PreferredSizeWidget {
  AppBarPageName({this.pageName, this.helpAlertTitle, this.helpAlertBody});
  final pageName;
  String helpAlertTitle;
  String helpAlertBody;

  @override
  Size get preferredSize => const Size.fromHeight(55);
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      iconTheme: IconThemeData(
        color: kPrimaryDarkColor, //change your color here
      ),
      backgroundColor: Colors.transparent,
      title: H1(
        textBody: pageName,
        color: kTextDarkColor,
      ),
      elevation: 0,
      actions: [
        ClipOval(
          child: Material(
            color: Colors.transparent, // button color
            child: InkWell(
              splashColor: kPrimaryAccentColor, // inkwell color
              child: SizedBox(
                width: 56,
                height: 56,
                child: Icon(
                  Icons.help,
                  color: kPrimaryAccentColor,
                ),
              ),
              onTap: () {
                Alert(
                    context: context,
                    title: helpAlertTitle,
                    style: AlertStyle(
                      titleStyle: H2TextStyle(color: kPrimaryAccentColor),
                    ),
                    content: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        H3(textBody: helpAlertBody),
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
          ),
        ),
        SizedBox(
          width: 0,
        ),
        ClipOval(
          child: Material(
            color: Colors.transparent, // button color
            child: InkWell(
              splashColor: kPrimaryAccentColor, // inkwell color
              child: SizedBox(
                width: 56,
                height: 56,
                child: Icon(
                  Icons.home,
                  color: kPrimaryAccentColor,
                ),
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
        SizedBox(
          width: 0,
        ),
      ],
    );
  }
}
