//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:grouped_buttons/grouped_buttons.dart';
//import 'package:provider/provider.dart';
//import 'background.dart';
//import 'package:rflutter_alert/rflutter_alert.dart';
//
//class Change_User_Type_FollowUp_State extends StatefulWidget {
//  final String fullName;
//  final String cnic;
//  final String password;
//  final String userType;
//  final String phone_no;
//
//  Change_User_Type_FollowUp_State({
//    this.fullName,
//    this.cnic,
//    this.password,
//    this.userType,
//    this.phone_no,
//  });
//
//  Change_User_Type_FollowUp createState() => Change_User_Type_FollowUp();
//}
//
//class Change_User_Type_FollowUp extends State<Change_User_Type_FollowUp_State> {
//  //Farmer Signup
//  Farmer fobject = new Farmer();
//
//  List<String> fServices = <String>[
//    'Pickup',
//    'Delivery',
//    'Pickup and Delivery',
//  ];
//  List<String> fCategories = <String>[
//    'Raw Product',
//    'End Product',
//  ];
//
//  //Customer
//  Customer cobject = new Customer();
//  List<String> cAccountTypes = [
//    'Individual',
//    'Commercial',
//  ];
//  //Supplier
//  Supplier sobject = new Supplier();
//  List<String> sTypes = [
//    'Fertilizer',
//    'Pesticide',
//    'Nutrients',
//    'Animal and Feed',
//    'Farm Tools and Machinery',
//  ];
//  @override
//  Widget build(BuildContext context) {
//    Size size = MediaQuery.of(context).size;
//    Widget signupButton = ButtonLoading(
//      labelText: "Update",
//      onTap: () async {
//        User user = User(
//          cnic: widget.cnic,
//          pass: widget.password,
//          fullName: widget.fullName,
//          usertype: widget.userType,
//          phone_no: widget.phone_no,
//          farmer: this.fobject,
//          customer: this.cobject,
//          supplier: this.sobject,
//        );
//        var check = await internetCheck();
//        if (check == false) {
//          Alert(
//              context: context,
//              title: "Check your internet connection",
//              style: AlertStyle(
//                titleStyle: H2TextStyle(color: kPrimaryAccentColor),
//              ),
//              content: Column(
//                children: <Widget>[
//                  SizedBox(
//                    height: 10,
//                  ),
//                  ButtonLoading(
//                    onTap: () async {
//                      Navigator.pop(context);
//                    },
//                    labelText: 'OK',
//                  ),
//                  SizedBox(
//                    height: 10,
//                  ),
//                ],
//              ),
//              buttons: [
//                DialogButton(
//                  color: Colors.white,
//                  height: 0,
//                ),
//              ]).show();
//        } else {
//          if (user.usertype == FARMER) {
//            print("Entered in farmer");
//            var check = await update_User_Type(user, user.farmer);
//            if (check == true) {
//              Provider.of<General_Provider>(context, listen: false)
//                  .set_user(user);
//              SnackBar sc = new SnackBar(
//                  content: Text(
//                "Updated Successfully",
//                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
//              ));
//              FirebaseAuth.instance.signOut();
//              Navigator.push(context, MaterialPageRoute(
//                builder: (context) {
//                  return LoginScreen();
//                },
//              ));
//            }
//          }
//          if (user.usertype == CUSTOMER) {
//            print("Entered in customer");
//            var check = await update_User_Type(user, user.customer);
//            if (check == true) {
//              Provider.of<General_Provider>(context, listen: false)
//                  .set_user(user);
//              SnackBar sc = new SnackBar(
//                  content: Text(
//                "Updated Successfully",
//                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
//              ));
//              FirebaseAuth.instance.signOut();
//              Navigator.push(context, MaterialPageRoute(
//                builder: (context) {
//                  return LoginScreen();
//                },
//              ));
//            }
//          }
//          if (user.usertype == SUPPLIER) {
//            var check = await update_User_Type(user, user.supplier);
//            if (check == true) {
//              Provider.of<General_Provider>(context, listen: false)
//                  .set_user(user);
//              SnackBar sc = new SnackBar(
//                  content: Text(
//                "Updated Successfully",
//                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
//              ));
//              FirebaseAuth.instance.signOut();
//              Navigator.push(context, MaterialPageRoute(
//                builder: (context) {
//                  return LoginScreen();
//                },
//              ));
//            }
//          }
//        }
//      },
//    );
//
//    //Farmer
//    Widget FProductTypeFollowUp() {
//      if (fobject.fCategory == null) return SizedBox(height: 1);
//      if (fobject.fCategory == "Raw Product")
//        return Column(
//          children: <Widget>[
//            RoundedInputField(
//              hintText: "Crops:",
//              icon: Icons.local_florist,
//              onChanged: (value) {
//                setState(() {
//                  fobject.fCrops = value.trim();
//                });
//              },
//            ),
//            RoundedInputField(
//              hintText: "Livestock:",
//              icon: Icons.local_florist,
//              onChanged: (value) {
//                setState(() {
//                  fobject.fAnimals = value.trim();
//                });
//              },
//            ),
//          ],
//        );
//      if (fobject.fCategory == "End Product")
//        return Column(
//          children: <Widget>[
//            RoundedInputField(
//              hintText: "Fresh Produce (Fruits and Vegetables):",
//              icon: Icons.panorama_wide_angle,
//              onChanged: (value) {
//                fobject.fFreshProduce = value.trim();
//              },
//            ),
//            RoundedInputField(
//              hintText: "Dairy:",
//              icon: Icons.panorama_wide_angle,
//              onChanged: (value) {
//                fobject.fDairy = value;
//              },
//            ),
//          ],
//        );
//    }
//
//    Widget FarmerSignUp() {
//      return Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          SizedBox(height: size.height * 0.05),
//          Text(
//            "FEW MORE QUESTIONS :)",
//            style: TextStyle(fontWeight: FontWeight.bold),
//          ),
//          SizedBox(height: size.height * 0.02),
//          Image.asset(
//            "assets/images/bgloginsignup.png",
//            width: double.infinity,
//            height: size.height * 0.1,
//          ),
//          SizedBox(height: size.height * 0.02),
//          RoundedInputField(
//            hintText: "Years of Experience",
//            icon: Icons.donut_large,
//            keyboardType: TextInputType.number,
//            onChanged: (value) {
//              fobject.fExperience = value.trim();
//            },
//          ),
//          RoundedInputField(
//            hintText: "Address/Location",
//            icon: Icons.pin_drop,
//            onChanged: (value) {
//              fobject.fAddress = value.trim();
//            },
//          ),
//          Container(
//            margin: EdgeInsets.symmetric(vertical: 5),
//            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//            width: size.width * 0.7,
//            decoration: new BoxDecoration(
//              color: kPrimaryLightColor,
//              borderRadius: BorderRadius.circular(29),
//            ),
//            child: Column(
//              children: <Widget>[
//                RoundedDropDown(
//                  name: "Service Type",
//                  size: size,
//                  text: fobject.fService,
//                  value: fobject.fService,
//                  onChanged: (String value) {
//                    setState(() {
//                      fobject.fService = value;
//                    });
//                  },
//                  items: fServices,
//                  icon: Icons.departure_board,
//                ),
//              ],
//            ),
//          ),
//          Container(
//            margin: EdgeInsets.symmetric(vertical: 5),
//            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//            width: size.width * 0.7,
//            decoration: new BoxDecoration(
//              color: kPrimaryLightColor,
//              borderRadius: BorderRadius.circular(29),
//            ),
//            child: Column(
//              children: <Widget>[
//                RoundedDropDown(
//                  name: "Produce Type",
//                  size: size,
//                  text: fobject.fCategory,
//                  value: fobject.fCategory,
//                  onChanged: (String value) {
//                    setState(() {
//                      fobject.fCategory = value;
//                    });
//                  },
//                  items: fCategories,
//                  icon: Icons.departure_board,
//                ),
//              ],
//            ),
//          ),
//          FProductTypeFollowUp(),
//          signupButton,
//          SizedBox(height: size.height * 0.02),
//        ],
//      );
//    }
//
//    //Supplier
//
//    Widget SupplierSignUp() {
//      return Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          SizedBox(height: size.height * 0.05),
//          Text(
//            "FEW MORE QUESTIONS :)",
//            style: TextStyle(fontWeight: FontWeight.bold),
//          ),
//          SizedBox(height: size.height * 0.02),
//          Image.asset(
//            "assets/images/bgloginsignup.png",
//            width: double.infinity,
//            height: size.height * 0.1,
//          ),
//          SizedBox(height: size.height * 0.02),
//          H1(
//            textBody: "Supplier Type:",
//          ),
//          CheckboxGroup(
//            //TODO: customize display according to brand standards
//            labels: <String>[
//              'Fertilizer',
//              'Pesticide',
//              'Nutrients',
//              'Animal and Feed',
//              'Farm Tools and Machinery',
//            ],
//            onSelected: (List<String> checked) {
//              sobject.sSelectedTypes = checked;
//            },
//          ),
//          RoundedInputField(
//            hintText: "Years of Experience:",
//            icon: Icons.local_florist,
//            keyboardType: TextInputType.number,
//            onChanged: (value) {
//              setState(() {
//                sobject.scExperience = value.trim();
//              });
//            },
//          ),
//          RoundedInputField(
//            hintText: "Address:",
//            icon: Icons.local_florist,
//            onChanged: (value) {
//              setState(() {
//                sobject.sAddress = value.trim();
//              });
//            },
//          ),
//          signupButton,
//          SizedBox(height: size.height * 0.02),
//          SizedBox(height: size.height * 0.02),
//        ],
//      );
//    }
//
//    //Customer
//    Widget CCustomerTypeFollowUp() {
//      if (cobject.cAccountType == "Commercial")
//        return Column(
//          children: <Widget>[
//            RoundedInputField(
//              hintText: "Company Name:",
//              icon: Icons.panorama_wide_angle,
//              onChanged: (value) {
//                setState(() {
//                  cobject.ccName = value;
//                });
//              },
//            ),
//            RoundedIntlPhoneField(
//              hintText: "Company Phone Number:",
//              onChanged: (value) {
//                cobject.ccPhoneNumber = value.trim();
//              },
//            ),
//            RoundedInputField(
//              hintText: "Company Website (optional):",
//              icon: Icons.panorama_wide_angle,
//              onChanged: (value) {
//                cobject.ccWebsite = value;
//              },
//            ),
//          ],
//        );
//      if (cobject.cAccountType == "Individual") {
//        return Column(
//          children: [
//            SizedBox(height: 1),
//            Text(
//              "NO MORE QUESTIONS, THANKYOU!",
//              style: TextStyle(fontWeight: FontWeight.bold),
//            ),
//          ],
//        );
//      }
//      return SizedBox(height: 1);
//    }
//
//    Widget CustomerSignUp() {
//      return Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          SizedBox(height: size.height * 0.05),
//          Text(
//            "FEW MORE QUESTIONS :)",
//            style: TextStyle(fontWeight: FontWeight.bold),
//          ),
//          SizedBox(height: size.height * 0.02),
//          Image.asset(
//            "assets/images/bgloginsignup.png",
//            width: double.infinity,
//            height: size.height * 0.1,
//          ),
//          SizedBox(height: size.height * 0.02),
//          Container(
//            margin: EdgeInsets.symmetric(vertical: 5),
//            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//            width: size.width * 0.7,
//            decoration: new BoxDecoration(
//              color: kPrimaryLightColor,
//              borderRadius: BorderRadius.circular(29),
//            ),
//            child: Column(
//              children: <Widget>[
//                RoundedDropDown(
//                  name: "Account Type",
//                  size: size,
//                  text: cobject.cAccountType,
//                  value: cobject.cAccountType,
//                  onChanged: (String value) {
//                    setState(() {
//                      cobject.cAccountType = value;
//                    });
//                  },
//                  items: cAccountTypes,
//                  icon: Icons.departure_board,
//                ),
//              ],
//            ),
//          ),
//          CCustomerTypeFollowUp(),
//          signupButton,
//          SizedBox(height: size.height * 0.02),
//        ],
//      );
//    }
//
//    Widget FollowUpSignUp() {
//      if (widget.userType == FARMER) {
//        return FarmerSignUp();
//      }
//      if (widget.userType == SUPPLIER) {
//        return SupplierSignUp();
//      }
//      if (widget.userType == CUSTOMER) {
//        return CustomerSignUp();
//      }
//    }
//
//    return Scaffold(
//      body: Background(
//        child: SingleChildScrollView(
//          child: FollowUpSignUp(),
//        ),
//      ),
//    );
//  }
//}
