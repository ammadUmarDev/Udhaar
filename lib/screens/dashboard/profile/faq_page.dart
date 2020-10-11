import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udhaar/components/appbar.dart';
import 'package:udhaar/components/body_text.dart';
import 'package:udhaar/components/h3.dart';

import '../../../constants.dart';

class FaqScreen extends StatefulWidget {
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  List<Panel> panels = [
    Panel(
        'Q: What is Udhaar all about?',
        'A: Udhaar is a money lending manager app that will keep track of the people (friends, etc.) who owe you money and those whom you owe money. If any user is hesitant to ask back for their lended money, Udhaar will send a reminder when close to the due date. Furthermore, Udhaar lets you add people as friends, request/approve a loan, keep track of the pending/cleared debts, and due dates.',
        false),
    Panel(
        'Q: How many accounts can I own?',
        'A: Corresponding to one email, you can create only one account.',
        false),
    Panel(
        'Q: Can I edit my profile?',
        'A: Yes, you can edit your profile by going to Profile->General Settings->User Settings.',
        false),
    Panel(
        'Q: Can I change my password?',
        'A: Yes, you can do this by going into Profile->Security Settings.',
        false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarPageName(
        pageName: "FAQs",
      ),
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: ListView(
            children: <Widget>[
              ...panels
                  .map((panel) => ExpansionTile(
                          title: H3(textBody: panel.title),
                          children: [
                            Container(
                                padding: EdgeInsets.all(16.0),
                                color: kTextLightColor.withOpacity(0.3),
                                child: BodyText(textBody: panel.content))
                          ]))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}

class Panel {
  String title;
  String content;
  bool expanded;

  Panel(this.title, this.content, this.expanded);
}
