import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../constants.dart';
import 'h3.dart';

class ButtonLoadingCircularLeft extends StatefulWidget {
  ButtonLoadingCircularLeft({@required this.onTap, @required this.labelText});

  final Function onTap;
  final String labelText;

  @override
  _ButtonLoadingCircularLeftState createState() =>
      _ButtonLoadingCircularLeftState();
}

class _ButtonLoadingCircularLeftState extends State<ButtonLoadingCircularLeft> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
          border: Border.all(
            width: 5,
            color: kPrimaryAccentColor,
            style: BorderStyle.solid,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 2,
            width: MediaQuery.of(context).size.width * 0.42,
          ),
          ArgonButton(
            height: 45,
            roundLoadingShape: true,
            width: MediaQuery.of(context).size.width * 0.40,
            onTap: (startLoading, stopLoading, btnState) async {
              if (btnState == ButtonState.Idle) {
                startLoading();
                widget.onTap();
                stopLoading();
              }
            },
            child: Text(widget.labelText,
                style: H3TextStyle(color: kTextDarkColor)),
            loader: Container(
              padding: EdgeInsets.all(10),
              child: SpinKitRotatingCircle(
                color: kPrimaryAccentColor,
              ),
            ),
            color: Color(0xFFeeeeee),
          ),
          SizedBox(height: 2),
        ],
      ),
    );
  }
}
