import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:udhaar/components/already_have_an_account_acheck.dart';
import 'package:udhaar/components/buttonErims.dart';
import 'package:udhaar/components/button_loading.dart';
import 'package:udhaar/components/button_loading_circularleft.dart';
import 'package:udhaar/components/h1.dart';
import 'package:udhaar/components/h2.dart';
import 'package:udhaar/components/h3.dart';
import 'package:udhaar/components/or_divider.dart';
import 'package:udhaar/components/text_Field_outlined.dart';
import 'package:udhaar/providers/general_provider.dart';
import 'package:udhaar/results_screen/GoogleDone.dart';
import 'package:udhaar/screens/authentication_handler/components/background.dart';
import 'package:udhaar/screens/dashboard/dashboard.dart';
import '../../constants.dart';
import '../../results_screen/Done.dart';
import 'RegisterPage.dart';

bool _wrongEmail = false;
bool _wrongPassword = false;

// ignore: deprecated_member_use
FirebaseUser _user;

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  static String id = '/LoginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool active = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ignore: deprecated_member_use
  Future<FirebaseUser> _handleSignIn() async {
    // hold the instance of the authenticated user
//    FirebaseUser user;
    // flag to check whether we're signed in already
    bool isSignedIn = await _googleSignIn.isSignedIn();
    if (isSignedIn) {
      // if so, return the current user
      _user = _auth.currentUser;
    } else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // get the credentials to (access / id token)
      // to sign in via Firebase Authentication
      // ignore: deprecated_member_use
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      _user = (await _auth.signInWithCredential(credential)).user;
    }

    return _user;
  }

  void onGoogleSignIn(BuildContext context) async {
    // ignore: deprecated_member_use
    FirebaseUser user = await _handleSignIn();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GoogleDone(user, _googleSignIn)));
  }

  @override
  Widget build(BuildContext context) {
    Widget welcomeBack = Text(
      'Welcome Back',
      style: TextStyle(
          color: Colors.white,
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
          shadows: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 5),
              blurRadius: 10.0,
            )
          ]),
    );

    Widget subTitle = Padding(
        padding: const EdgeInsets.only(right: 56.0, top: 20),
        child: H1(
          textBody: 'Login to your account using\nEmail',
          color: kTextLightColor,
        ));

    TextFieldOutlined emailTextField = TextFieldOutlined(
      textFieldText: 'Email (example@gmail.com)',
      textFieldIcon: Icon(
        FontAwesomeIcons.solidEnvelopeOpen,
        size: iconSize,
        color: kIconColor,
      ),
      keyboardType: TextInputType.emailAddress,
      isValidEntry: (entry) {
        if (entry.toString().contains('@') && entry.toString().endsWith('.com'))
          return '';
        return 'Invalid Email';
      },
      onChanged: () {},
    );
    TextFieldOutlined passwordTextField = TextFieldOutlined(
      textFieldText: 'Password',
      textFieldIcon: Icon(
        FontAwesomeIcons.lock,
        size: iconSize,
        color: kIconColor,
      ),
      obscure: true,
      keyboardType: TextInputType.visiblePassword,
      isValidEntry: (entry) {
        if (entry.toString().length <= 6)
          return 'Min Password Length: 6 characters';
        return '';
      },
    );

    void _showDialog() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content:
              Text("Invalid Username or Password"), //TODO: make dialog pretty
        ),
      );
    }

    Widget loginButton = ButtonErims(
      onTap: (startLoading, stopLoading, btnState) async {
        if (btnState == ButtonState.Idle) {
          startLoading();
          print('Attempting signing  in:');
          print(emailTextField.getReturnValue());
          print(passwordTextField.getReturnValue());
          try {
            UserCredential userCredential = await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: emailTextField.getReturnValue(),
                    password: passwordTextField.getReturnValue());
            FirebaseAuth.instance.authStateChanges().listen((User user) {
              if (user == null) {
                print('User unauthenticated');
              } else {
                print("Login successful");
              }
              if (_auth.currentUser != null) {
                print(_auth.currentUser.uid);
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return DashBoard();
                  },
                ));
              }
            });
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              print('No user found for that email.');
            } else if (e.code == 'wrong-password') {
              print('Wrong password provided for that user.');
            }
          }
          stopLoading();
        } else {
          stopLoading();
        }
      },
      labelText: "SIGN IN",
    );

    // ignore: non_constant_identifier_names
    Widget SigninForm = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 32.0, right: 12.0),
            decoration: BoxDecoration(
                color: Color(0xFFeeeeee),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                emailTextField,
                SizedBox(height: 10.0),
                passwordTextField,
                SizedBox(height: 20.0),
              ],
            ),
          ),
          SizedBox(height: 15),
          loginButton,
        ],
      ),
    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: CustomPaint(
        painter: AuthBackground(),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Spacer(flex: 3),
                  welcomeBack,
                  subTitle,
                  Spacer(flex: 1),
                  SigninForm,
                  Spacer(flex: 2),
                  Center(child: OrDivider()),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    margin:
                        EdgeInsets.only(left: 40.0, right: 40.0, bottom: 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: RaisedButton(
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/google_logo.png',
                              height: 25.0,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20.0),
                              child: H2(
                                textBody: 'Login with Google',
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          onGoogleSignIn(context);
                        },
                      ),
                    ),
                  ),

                  AlreadyHaveAnAccountCheck(
                    login: true,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return RegisterPage();
                          },
                        ),
                      );
                    },
                  ),
                  Spacer(flex: 1),
//                  forgotPassword
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
