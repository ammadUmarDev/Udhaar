import 'package:flutter/material.dart';
import 'package:udhaar/components/h2.dart';
import 'package:udhaar/components/h3.dart';
import 'package:udhaar/constants.dart';

import 'body_text.dart';

// ignore: must_be_immutable
class TextFieldOutlined extends StatefulWidget {
  TextEditingController _textEditingController = TextEditingController();

  TextFieldOutlined({
    this.textFieldIcon = const Icon(
      Icons.keyboard,
    ),
    this.textFieldText,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
    this.isValidEntry,
    this.onChanged,
  }) {
    if (isValidEntry == null) {
      isValidEntry = (dynamic a) {
        return '';
      };
    }
  }
  Function onChanged;
  final Icon textFieldIcon;
  final String textFieldText;
  final bool obscure;
  final TextInputType keyboardType;
  dynamic retValue;
  String Function(dynamic)
      isValidEntry; //checks if the entry complies with pre set restrictions

  @override
  _TextFieldOutlinedState createState() => _TextFieldOutlinedState();

  dynamic getReturnValue() => retValue;
}

class _TextFieldOutlinedState extends State<TextFieldOutlined> {
  Color color = kPrimaryAccentColor;
  String warningMessage = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 50.0,
          color: kTextLightColor,
          child: TextFormField(
            style: H2TextStyle(),
            cursorColor: kPrimaryAccentColor,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryAccentColor, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black45, width: 2.0),
              ),
              labelText: widget.textFieldText,
              prefixIcon: widget.textFieldIcon,
              labelStyle: H3TextStyle(color: kTextDarkColor),
            ),
            keyboardType: widget.keyboardType,
            maxLines: (widget.keyboardType == TextInputType.multiline) ? 3 : 1,
            obscureText: widget.obscure,
            controller: widget._textEditingController,
            onChanged: (value) {
              setState(() {
                warningMessage = widget.isValidEntry(value);
                print(warningMessage);
                if (warningMessage == '') {
                  widget.retValue = value;
                  color = kPrimaryAccentColor;
                } else {
                  color = kPrimaryAccentColor;
                }
              });
            },
          ),
        ),
        (warningMessage != '')
            ? (Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  warningMessage,
                  textAlign: TextAlign.left,
                  style: BodyTextStyle(color: Colors.red),
                ),
              ))
            : (Container(
                height: 0.0,
              )),
      ],
    );
  }
}
