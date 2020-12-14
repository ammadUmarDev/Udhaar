import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          textBody: 'Sign up for your an account using\nEmail',
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
                  friendList: [],
                  friendsLended: [],
                  friendsOwed: [],
                  pendingLoanApprovalsRequests: [],
                  pendingPaybackConfirmations: [],
                  pendingLoanApprovalsRequestsCount: 0,
                  pendingPaybackConfirmationsCount: 0,
                  totalAmountLended: 0.0,
                  totalAmountOwed: 0.0,
                  totalFriendsLended: 0,
                  totalFriendsOwed: 0,
                  totalFriends: 0,
                  totalRequests: 0,
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

    // ignore: non_constant_identifier_names
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
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        color: kPrimaryAccentColor,
        child: CustomPaint(
          painter: AuthBackground(),
          child: SafeArea(
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height / 20),
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
                        margin: EdgeInsets.only(
                            left: 40.0, right: 40.0, bottom: 20),
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
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 20.0),
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
                                      child: SizedBox(height: 0),
                                      onPressed: () {},
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
      ),
    );
  }
}
