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
        'Q: How many accounts can I own?',
        'A: Corresponding to one phone number, or one CNIC number, you can create only one account.',
        false),
    Panel('Q: How long does delivery take?',
        'A: Delivery usually takes 5-7 business days.', false),
    Panel('Q: Can I change my order?',
        'A: You can track your order by going to Profile->My Orders.', false),
    Panel(
        'Q: Can I edit my profile?',
        'A: Yes, you can edit your profile by going to Profile->General Settings->User Settings.',
        false),
    Panel(
        'Q: If I have an account already as a Customer but want to start selling can I change my account?',
        'A: Yes, you can change your account type in settings. You may have to provide additional information.',
        false),
    Panel(
        'Q: Can I edit my existing products?',
        'A: Yes, you can edit your existing products under ‘My Products’.',
        false),
    Panel(
        'Q: Can I change my password?',
        'A: Yes, you can do this by going into Profile->Security Settings.',
        false),
    Panel(
        'Q: How can I pay for my order?',
        'A: Currently, you can only pay by cash on delivery or cash on pickup. We will be adding more options in future.',
        false),
    Panel(
        'Q: Do I always have to confirm a customer’s order?',
        'A: No, you can choose to not confirm a customer’s order, or cancel it.',
        false),
    Panel(
        'Q: Can customers contact me?',
        'A: Yes, the customers can contact you on your given contact details (phone number, email address). ',
        false)
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
