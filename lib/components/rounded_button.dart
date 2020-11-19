import 'package:flutter/material.dart';
import 'h2.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color,
    this.textColor,
  }) : super(key: key);
  final String text;
  final Function press;
  final Color color, textColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          color: color,
          onPressed: press,
          child: H2(
            textBody: text,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
