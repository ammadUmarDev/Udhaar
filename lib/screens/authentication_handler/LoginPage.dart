import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
import 'package:udhaar/providers/general_provider.dart';
import 'package:udhaar/screens/authentication_handler/components/background.dart';
import 'package:udhaar/screens/dashboard/dashboard.dart';
import '../../constants.dart';
import 'RegisterPage.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  static String id = '/LoginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool active = false;
  bool authCheckFields = false;
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

    Widget loginButton = ButtonErims(
      onTap: (startLoading, stopLoading, btnState) async {
        if (btnState == ButtonState.Idle) {
          startLoading();
          print('Attempting signing  in:');
          print(emailTextField.getReturnValue());
          print(passwordTextField.getReturnValue());
          String emailRetValue =
              emailTextField.getReturnValue().toString().trim();
          String passRetValue =
              passwordTextField.getReturnValue().toString().trim();
          try {
            if (emailRetValue.toString().contains('@') != false &&
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
              final signInUser = (await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: emailTextField.getReturnValue().trim(),
                          password: passwordTextField.getReturnValue().trim()))
                  .user;
              print("we here ");
              if (signInUser != null) {
                final currentUserId = signInUser.uid;
                print(currentUserId);
                UserModel retGetUserObjFirebase;
                //TODO: This function below returns null and provier is unable to save obj
                FirebaseFirestore db = FirebaseFirestore.instance;
                CollectionReference users = db.collection('Users');
                await users
                    .doc(currentUserId)
                    .get()
                    .then((DocumentSnapshot documentSnapshot) {
                  if (documentSnapshot.exists) {
                    print('Document exist on the database');
                    retGetUserObjFirebase = UserModel(
                      email: documentSnapshot.data()["Email"].toString(),
                      fullName: documentSnapshot.data()["Full_Name"].toString(),
                      userID: documentSnapshot.data()["User_Id"].toString(),
                      createdDate:
                          documentSnapshot.data()["Created_Date"].toString(),
                      lastPassChangeDate: documentSnapshot
                          .data()["Last_Pass_Change_Date"]
                          .toString(),
                      friendList:
                          documentSnapshot.data()["Friend_List"].split(","),
                    );
                  }
                });
                if (retGetUserObjFirebase != null) {
                  try {
                    print("dsdsad" + retGetUserObjFirebase.userID);
                    Provider.of<General_Provider>(context, listen: false)
                        .set_user(retGetUserObjFirebase);
                    try {
                      Provider.of<General_Provider>(context, listen: false)
                          .set_firebase_user(signInUser);
                      print("User Signed In, Proceeding to Dashboard");
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return DashBoard();
                        },
                      ));
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
                    stopLoading();
                  } catch (e) {
                    print(e);
                  }
                } else {
                  print("retGetUserDocFirebase is null");
                }
              }
            }
          } catch (e) {
            print(e);
          }
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
      backgroundColor: Colors.white,
      body: CustomPaint(
        painter: AuthBackground(),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(flex: 1),
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
      ),
    );
  }
}
