import 'package:flutter/material.dart';
import 'package:udhaar/components/body_text.dart';
import 'package:udhaar/components/h1.dart';

import '../../../constants.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
            colors: [
              kPrimaryAccentColor,
              kPrimaryLightColor,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Udhaar",
                            style: TextStyle(
                              fontFamily: "Cantarell",
                              fontSize: 40.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Money Lending Manager",
                            style: TextStyle(
                              fontFamily: "Cantarell",
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: ListView(
                    children: <Widget>[
                      H1(textBody: "Get to know us"),
                      SizedBox(height: 5),
                      BodyText(
                          textBody:
                              "Welcome to Suivantec®. We provide intelligent solutions to unlock new possibilities. Together, we can bring your ideas to life so reach out for a new project."),
                      SizedBox(height: 15),
                      H1(textBody: "What is Udhaar ® ?"),
                      SizedBox(height: 5),
                      BodyText(
                          textBody:
                              "Udhaar is a money lending manager app that will keep track of the people (friends, etc.) who owe you money and those whom you owe money. If any user is hesitant to ask back for their lended money, Udhaar will send a reminder when close to the due date. Furthermore, Udhaar lets you add people as friends, request/approve a loan, keep track of the pending/cleared debts, and due dates."),
                      SizedBox(height: 15),
                      H1(textBody: "Contact us"),
                      SizedBox(height: 5),
                      BodyText(
                          textBody:
                              "Reach out to Suivantec® at suivantec.contact@gmail.com"),
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
