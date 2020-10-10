import 'package:flutter/material.dart';
import 'package:udhaar/constants.dart';

class AuthBackground extends CustomPainter {
  AuthBackground();

  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;
    canvas.drawRect(
        Rect.fromLTRB(0, 0, width, height), Paint()..color = kPrimaryDarkColor);
    canvas.drawRect(Rect.fromLTRB(width - (width / 3.2), 0, width, height),
        Paint()..color = kPrimaryLightColor);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
