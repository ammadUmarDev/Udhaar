import 'package:flutter/material.dart';
import '../constants.dart';

class ShadowBoxList extends StatelessWidget {
  final Icon icon;
  final widgetColumn;
  final Function onTapFunction;

  ShadowBoxList({this.icon, this.onTapFunction, this.widgetColumn});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: kPrimaryAccentColor.withOpacity(0.5),
                blurRadius: 20.0, // has the effect of softening the shadow
                spreadRadius: 0.1, // has the effect of extending the shadow
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Center(
                  child: icon,
                ),
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widgetColumn,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: onTapFunction,
      ),
    );
  }
}
