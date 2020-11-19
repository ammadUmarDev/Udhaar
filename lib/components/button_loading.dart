import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../constants.dart';
import 'h3.dart';

class ButtonLoading extends StatefulWidget {
  ButtonLoading({@required this.onTap, @required this.labelText});

  final Function onTap;
  final String labelText;

  @override
  _ButtonLoadingState createState() => _ButtonLoadingState();
}

class _ButtonLoadingState extends State<ButtonLoading> {
  @override
  Widget build(BuildContext context) {
    return ArgonButton(
      height: 45,
      roundLoadingShape: true,
      width: MediaQuery.of(context).size.width * 0.35,
      onTap: (startLoading, stopLoading, btnState) async {
        if (btnState == ButtonState.Idle) {
          startLoading();
          widget.onTap();
          stopLoading();
        }
      },
      child: Text(widget.labelText, style: H3TextStyle(color: kTextLightColor)),
      loader: Container(
        padding: EdgeInsets.all(10),
        child: SpinKitRotatingCircle(
          color: kPrimaryAccentColor,
        ),
      ),
      borderRadius: 20.0,
      color: kPrimaryAccentColor,
      borderSide: BorderSide(
        color: kPrimaryAccentColor,
        width: 5.0,
      ),
    );
  }
}
