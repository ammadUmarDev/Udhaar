import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:udhaar/components/h3.dart';
import 'package:udhaar/constants.dart';

// ignore: must_be_immutable
class ButtonErims extends StatefulWidget {
  ButtonErims({@required this.onTap, @required this.labelText});

  dynamic Function(Function, Function, ButtonState) onTap;
  String labelText;

  @override
  _ButtonErimsState createState() => _ButtonErimsState();
}

class _ButtonErimsState extends State<ButtonErims> {
  @override
  Widget build(BuildContext context) {
    return ArgonButton(
      height: 45,
      roundLoadingShape: true,
      width: MediaQuery.of(context).size.width * 0.45,
      onTap: widget.onTap,
      child: Text(widget.labelText, style: H3TextStyle()),
      loader: Container(
        padding: EdgeInsets.all(10),
        child: SpinKitRotatingCircle(
          color: kPrimaryAccentColor,
        ),
      ),
      borderRadius: 10.0,
      color: kTextLightColor,
      borderSide: BorderSide(
        color: kPrimaryAccentColor,
        width: 4.0,
      ),
    );
  }
}
