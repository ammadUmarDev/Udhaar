import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'h1.dart';

class AppBarPageName extends StatelessWidget implements PreferredSizeWidget {
  AppBarPageName({this.pageName});
  final pageName;
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
        color: kPrimaryDarkColor,
      ),
      elevation: 0,
      actions: [
        ClipOval(
          child: Material(
            color: Colors.white, // button color
            child: InkWell(
              splashColor: kPrimaryLightColor, // inkwell color
              child: SizedBox(
                width: 56,
                height: 56,
                child: Icon(
                  Icons.home,
                  color: kPrimaryDarkColor,
                ),
              ),
              onTap: () {},
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        ClipOval(
          child: Material(
            color: Colors.white, // button color
            child: InkWell(
              splashColor: kPrimaryLightColor, // inkwell color
              child: SizedBox(
                width: 56,
                height: 56,
                child: Icon(
                  Icons.shopping_cart,
                  color: kPrimaryDarkColor,
                ),
              ),
              onTap: () {},
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
