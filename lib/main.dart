import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udhaar/providers/general_provider.dart';
import 'package:udhaar/results_screen/ForgotPassword.dart';
import 'package:udhaar/screens/authentication_handler/LoginPage.dart';
import 'package:udhaar/screens/authentication_handler/RegisterPage.dart';
import 'results_screen/Done.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Provider.debugCheckInvalidValueType = null;
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<General_Provider>(create: (context) => General_Provider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RegisterPage.id,
        routes: {
          RegisterPage.id: (context) => RegisterPage(),
          LoginPage.id: (context) => LoginPage(),
          ForgotPassword.id: (context) => ForgotPassword(),
          Done.id: (context) => Done(),
        },
      ),
    );
  }
}
