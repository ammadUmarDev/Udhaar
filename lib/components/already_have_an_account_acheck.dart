import 'package:flutter/material.dart';
import 'package:udhaar/components/h3.dart';

import '../constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        H3(
          textBody:
              login ? "Don’t have an Account ? " : "Already have an Account ? ",
          color: kTextLightColor,
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "  Sign Up" : "  Sign In",
            style: TextStyle(
              color: kTextLightColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
