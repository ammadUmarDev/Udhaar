import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';
import 'body_text.dart';

// ignore: must_be_immutable
class CategoryDisplay extends StatelessWidget {
  double width, height = 55.0;
  double customFontSize = 13;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                      child: RawMaterialButton(
                        onPressed: () {},
                        shape: CircleBorder(),
                        child: Icon(
                          FontAwesomeIcons.box,
                          color: kPrimaryDarkColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    BodyText(textBody: "Catagory Name"),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                      child: RawMaterialButton(
                        onPressed: () {},
                        shape: CircleBorder(),
                        child: Icon(
                          FontAwesomeIcons.box,
                          color: kPrimaryDarkColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    BodyText(textBody: "Catagory Name"),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                      child: RawMaterialButton(
                        onPressed: () {},
                        shape: CircleBorder(),
                        child: Icon(
                          FontAwesomeIcons.box,
                          color: kPrimaryDarkColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    BodyText(textBody: "Catagory Name"),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                      child: RawMaterialButton(
                        onPressed: () {},
                        shape: CircleBorder(),
                        child: Icon(
                          FontAwesomeIcons.box,
                          color: kPrimaryDarkColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    BodyText(textBody: "Catagory Name"),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                      child: RawMaterialButton(
                        onPressed: () {},
                        shape: CircleBorder(),
                        child: Icon(
                          FontAwesomeIcons.box,
                          color: kPrimaryDarkColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    BodyText(textBody: "Catagory Name"),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                      child: RawMaterialButton(
                        onPressed: () {},
                        shape: CircleBorder(),
                        child: Icon(
                          FontAwesomeIcons.box,
                          color: kPrimaryDarkColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    BodyText(textBody: "Catagory Name"),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                      child: RawMaterialButton(
                        onPressed: () {},
                        shape: CircleBorder(),
                        child: Icon(
                          FontAwesomeIcons.box,
                          color: kPrimaryDarkColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    BodyText(textBody: "Catagory Name"),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                      child: RawMaterialButton(
                        onPressed: () {},
                        shape: CircleBorder(),
                        child: Icon(
                          FontAwesomeIcons.leaf,
                          color: kPrimaryDarkColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    BodyText(textBody: "Catagory Name"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
