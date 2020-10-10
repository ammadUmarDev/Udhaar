import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class H2TextStyle extends TextStyle {
  H2TextStyle({this.color});
  final fontFamily = "Cantarell";
  final fontSize = h2Size;
  final Color color;
  final fontWeight = FontWeight.w600;
}

class H2 extends StatelessWidget {
  H2({
    this.textBody,
    this.color = kTextDarkColor,
  });
  final String textBody;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      textBody,
      style: H2TextStyle(color: color),
    );
  }
}
