import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:udhaar/components/h2.dart';
import '../components/main_background.dart';

class DashboardNotification extends StatefulWidget {
  @override
  _DashboardNotificationState createState() => _DashboardNotificationState();
}

class _DashboardNotificationState extends State<DashboardNotification> {
  SwiperController swiperController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: MainBackground(),
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                    child: SizedBox(
                  height: 0,
                )),
              ];
            },
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  H2(
                    textBody: "Notifications\nComing Soon",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
