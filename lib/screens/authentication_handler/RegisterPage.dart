import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:udhaar/components/already_have_an_account_acheck.dart';
import 'package:udhaar/components/buttonErims.dart';
import 'package:udhaar/components/h1.dart';
import 'package:udhaar/components/h2.dart';
import 'package:udhaar/components/h3.dart';
import 'package:udhaar/components/or_divider.dart';
import 'package:udhaar/components/text_Field_outlined.dart';
import 'package:udhaar/models/User_Model.dart';
import 'package:udhaar/providers/firebase_functions.dart';
import 'package:udhaar/providers/general_provider.dart';
import 'package:udhaar/results_screen/GoogleDone.dart';
import 'package:udhaar/screens/authentication_handler/components/background.dart';
import 'package:udhaar/screens/dashboard/dashboard.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import 'LoginPage.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  static String id = '/RegisterPage';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String name;
  String email;
  String password;
  bool authCheckFields = false;
  bool _showSpinner = false;

  TextFieldOutlined fullNameTextField = TextFieldOutlined(
    textFieldText: 'Full Name (example: Donald Trump)',
    textFieldIcon: Icon(FontAwesomeIcons.solidUser, size: iconSize),
    keyboardType: TextInputType.emailAddress,
    isValidEntry: (entry) {
      if (entry.toString().isEmpty &&
          entry.toString().startsWith(' ') &&
          entry.toString().endsWith(' ') &&
          entry.toString().contains(' ') == false) {
        return 'Invalid Full Name';
      }
      return '';
    },
  );
  TextFieldOutlined emailTextField = TextFieldOutlined(
    textFieldText: 'Email (example@gmail.com)',
    textFieldIcon: Icon(FontAwesomeIcons.solidEnvelopeOpen, size: iconSize),
    keyboardType: TextInputType.emailAddress,
    isValidEntry: (entry) {
      if (entry.toString().contains('@') && entry.toString().endsWith('.com'))
        return '';
      return 'Invalid Email';
    },
  );
  TextFieldOutlined passwordTextField = TextFieldOutlined(
    textFieldText: 'Password',
    textFieldIcon: Icon(FontAwesomeIcons.lock, size: iconSize),
    obscure: true,
    keyboardType: TextInputType.visiblePassword,
    isValidEntry: (entry) {
      if (entry.toString().length <= 6)
        return 'Min Password Length: 6 characters';
      return '';
    },
  );

  @override
  Widget build(BuildContext context) {
    Widget welcome = Text(
      'Welcome',
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
          textBody: 'Sign into your account using\nEmail',
          color: kTextLightColor,
        ));
    Widget registerButton = ButtonErims(
      onTap: (startLoading, stopLoading, btnState) async {
        if (btnState == ButtonState.Idle) {
          startLoading();
          print('User Signing Up:');
          print(fullNameTextField.getReturnValue());
          print(emailTextField.getReturnValue());
          print(passwordTextField.getReturnValue());
          String fullNameRetValue =
              fullNameTextField.getReturnValue().toString();
          String emailRetValue =
              emailTextField.getReturnValue().toString().trim();
          String passRetValue =
              passwordTextField.getReturnValue().toString().trim();
          try {
            if (fullNameRetValue.toString().isEmpty &&
                fullNameRetValue.toString().startsWith(' ') &&
                fullNameRetValue.toString().endsWith(' ') &&
                fullNameRetValue.toString().contains(' ') == false &&
                emailRetValue.toString().contains('@') != false &&
                emailRetValue.toString().endsWith('.com') != false &&
                passRetValue.toString().length <= 6) {
              setState(() {
                //cannot allow signup
                authCheckFields = false;
              });
            } else {
              setState(() {
                //allow signup
                authCheckFields = true;
              });
            }
            if (authCheckFields == true) {
              final createUser = (await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: emailTextField.getReturnValue().trim(),
                          password: passwordTextField.getReturnValue().trim()))
                  .user;
              if (createUser != null) {
                final currentUserId = createUser.uid;
                final createdUserModelObj = UserModel(
                  userID: currentUserId,
                  fullName: fullNameTextField.getReturnValue(),
                  email: emailTextField.getReturnValue().trim(),
                  createdDate: DateFormat("dd/MM/yyyy")
                      .format(DateTime.now())
                      .toString(),
                  lastPassChangeDate: DateFormat("dd/MM/yyyy")
                      .format(DateTime.now())
                      .toString(),
                );
                signupFirebaseDb(createdUserModelObj).then((retUser) async {
                  try {
                    Provider.of<General_Provider>(context, listen: false)
                        .set_user(createdUserModelObj);
                    try {
                      Provider.of<General_Provider>(context, listen: false)
                          .set_firebase_user(createUser);
                      print("User Created, Proceeding to Dashboard");
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return DashBoard();
                        },
                      ));
                      stopLoading();
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }

                    print('set_firebase_user');
                  } catch (e) {
                    print(e);
                  }
                });
                ;
              }
            }
          } catch (e) {
            print(e);
          }
        } else {
          stopLoading();
        }
      },
      labelText: "SIGN UP",
    );

    Widget SiginForm = Container(
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
                SizedBox(height: 20),
                fullNameTextField,
                SizedBox(height: 10),
                emailTextField,
                SizedBox(height: 10),
                passwordTextField,
                SizedBox(height: 20),
              ],
            ),
          ),
          SizedBox(height: 15),
          registerButton,
        ],
      ),
    );
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        color: kPrimaryAccentColor,
        child: CustomPaint(
          painter: AuthBackground(),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 28.0),
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height / 10),
                    welcome,
                    subTitle,
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    SiginForm,
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
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
                                  textBody: 'Continue with Google',
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Alert(
                                context: context,
                                title: "Coming Soon",
                                style: AlertStyle(
                                  titleStyle:
                                      H2TextStyle(color: kPrimaryAccentColor),
                                ),
                                content: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    H3(
                                        textBody:
                                            "Stay tuned for the next update :)"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                                buttons: [
                                  DialogButton(
                                    color: Colors.white,
                                    height: 0,
                                  ),
                                ]).show();
                          },
                        ),
                      ),
                    ),
                    AlreadyHaveAnAccountCheck(
                      login: false,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginPage();
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
//                  forgotPassword
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

//    return Scaffold(
//      backgroundColor: Colors.white,
//      resizeToAvoidBottomPadding: false,
//      body: ModalProgressHUD(
//        inAsyncCall: _showSpinner,
//        color: Colors.blueAccent,
//        child: Stack(
//          children: [
//            Padding(
//              padding: EdgeInsets.only(
//                  top: 60.0, bottom: 20.0, left: 20.0, right: 20.0),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.stretch,
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: [
//                  Column(
//                    children: [
//                      TextField(
//                        keyboardType: TextInputType.name,
//                        onChanged: (value) {
//                          name = value;
//                        },
//                        decoration: InputDecoration(
//                          hintText: 'Full Name',
//                          labelText: 'Full Name',
//                        ),
//                      ),
//                      SizedBox(height: 20.0),
//                      TextField(
//                        keyboardType: TextInputType.emailAddress,
//                        onChanged: (value) {
//                          email = value;
//                        },
//                        decoration: InputDecoration(
//                          labelText: 'Email',
//                          errorText: _wrongEmail ? _emailText : null,
//                        ),
//                      ),
//                      SizedBox(height: 20.0),
//                      TextField(
//                        obscureText: true,
//                        keyboardType: TextInputType.visiblePassword,
//                        onChanged: (value) {
//                          password = value;
//                        },
//                        decoration: InputDecoration(
//                          labelText: 'Password',
//                          errorText: _wrongPassword ? _passwordText : null,
//                        ),
//                      ),
//                      SizedBox(height: 10.0),
//                    ],
//                  ),
//                  RaisedButton(
//                    padding: EdgeInsets.symmetric(vertical: 10.0),
//                    color: Color(0xff447def),
//                    onPressed: () async {
//                      setState(() {
//                        _wrongEmail = false;
//                        _wrongPassword = false;
//                      });
//                      try {
//                        if (validator.isEmail(email) &
//                            validator.isLength(password, 6)) {
//                          setState(() {
//                            _showSpinner = true;
//                          });
//                          final newUser =
//                              await _auth.createUserWithEmailAndPassword(
//                            email: email,
//                            password: password,
//                          );
//                          if (newUser != null) {
//                            print('user authenticated by registration');
//                            Navigator.pushNamed(context, Done.id);
//                          }
//                        }
//
//                        setState(() {
//                          if (!validator.isEmail(email)) {
//                            _wrongEmail = true;
//                          } else if (!validator.isLength(password, 6)) {
//                            _wrongPassword = true;
//                          } else {
//                            _wrongEmail = true;
//                            _wrongPassword = true;
//                          }
//                        });
//                      } catch (e) {
//                        setState(() {
//                          _wrongEmail = true;
//                          if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
//                            _emailText =
//                                'The email address is already in use by another account';
//                          }
//                        });
//                      }
//                    },
//                    child: Text(
//                      'Register',
//                      style: TextStyle(fontSize: 25.0, color: Colors.white),
//                    ),
//                  ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: [
//                      Padding(
//                        padding: EdgeInsets.symmetric(horizontal: 10.0),
//                        child: Container(
//                          height: 1.0,
//                          width: 60.0,
//                          color: Colors.black87,
//                        ),
//                      ),
//                      Text(
//                        'Or',
//                        style: TextStyle(fontSize: 25.0),
//                      ),
//                      Padding(
//                        padding: EdgeInsets.symmetric(horizontal: 10.0),
//                        child: Container(
//                          height: 1.0,
//                          width: 60.0,
//                          color: Colors.black87,
//                        ),
//                      ),
//                    ],
//                  ),
//                  Row(
//                    children: [
//                      Expanded(
//                        child: RaisedButton(
//                          padding: EdgeInsets.symmetric(vertical: 5.0),
//                          color: Colors.white,
//                          shape: ContinuousRectangleBorder(
//                            side:
//                                BorderSide(width: 0.5, color: Colors.grey[400]),
//                          ),
//                          onPressed: () {
//                            onGoogleSignIn(context);
//                          },
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: [
//                              Image.asset('assets/images/google.png',
//                                  fit: BoxFit.contain,
//                                  width: 40.0,
//                                  height: 40.0),
//                              Text(
//                                'Google',
//                                style: TextStyle(
//                                    fontSize: 25.0, color: Colors.black),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                      SizedBox(width: 20.0),
//                      Expanded(
//                        child: RaisedButton(
//                          padding: EdgeInsets.symmetric(vertical: 5.0),
//                          color: Colors.white,
//                          shape: ContinuousRectangleBorder(
//                            side:
//                                BorderSide(width: 0.5, color: Colors.grey[400]),
//                          ),
//                          onPressed: () {
//                            //TODO: Implement facebook functionality
//                          },
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: [
//                              Image.asset('assets/images/facebook.png',
//                                  fit: BoxFit.cover, width: 40.0, height: 40.0),
//                              Text(
//                                'Facebook',
//                                style: TextStyle(
//                                    fontSize: 25.0, color: Colors.black),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: [
//                      Text(
//                        'Already have an account?',
//                        style: TextStyle(fontSize: 25.0),
//                      ),
//                      GestureDetector(
//                        onTap: () {
//                          Navigator.pushNamed(context, LoginPage.id);
//                        },
//                        child: Text(
//                          ' Sign In',
//                          style: TextStyle(fontSize: 25.0, color: Colors.blue),
//                        ),
//                      ),
//                    ],
//                  ),
//                ],
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
  }
}
