import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class BodyTextStyle extends TextStyle {
  final fontFamily = "Cantarell";
  final fontSize = pSize;
  final Color color;
  BodyTextStyle({this.color = const Color(0xFF35495e)});
}

class BodyText extends StatelessWidget {
  BodyText({
    this.textBody,
    this.color = Colors.black87,
    this.align,
  });
  final String textBody;
  final Color color;
  final TextAlign align;
  @override
  Widget build(BuildContext context) {
    return Text(
      textBody,
      style: BodyTextStyle(
        color: color,
      ),
      textAlign: align,
    );
  }
}
