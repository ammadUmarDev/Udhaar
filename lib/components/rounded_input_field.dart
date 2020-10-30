import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:udhaar/components/text_field_container.dart';

import '../constants.dart';

// ignore: must_be_immutable
class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final keyboardType;
  final enabled;
  Set<TextInputFormatter> inputFormatters = Set<TextInputFormatter>();
  RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
    this.keyboardType,
    this.enabled,
    inputFormatters,
  }) : super(key: key) {
    if (inputFormatters != null) this.inputFormatters = inputFormatters;
  }

  @override
  Widget build(BuildContext context) {
    if (keyboardType == TextInputType.number) {
      inputFormatters.add(WhitelistingTextInputFormatter.digitsOnly);
    }
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryDarkColor,
        keyboardType: this.keyboardType,
        enabled: this.enabled,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kIconColor,
            size: iconSize,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
        inputFormatters: inputFormatters.toList(),
      ),
    );
  }
}
