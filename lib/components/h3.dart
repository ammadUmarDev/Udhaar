import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class H3TextStyle extends TextStyle {
  H3TextStyle({this.color});
  final fontFamily = "Cantarell";
  final fontSize = h3Size;
  final Color color;
  final fontWeight = FontWeight.w600;
}

class H3 extends StatelessWidget {
  H3({
    this.textBody,
    this.color = kPrimaryDarkColor,
  });
  final String textBody;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      textBody,
      style: H3TextStyle(color: color),
      overflow: TextOverflow.ellipsis,
      maxLines: 5,
    );
  }
}
