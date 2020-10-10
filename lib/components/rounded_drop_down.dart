import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'h2.dart';

class RoundedDropDown extends StatefulWidget {
  const RoundedDropDown({
    Key key,
    this.name,
    this.size,
    this.text,
    this.value,
    this.onChanged,
    this.items,
    this.icon,
  }) : super(key: key);
  final String name;
  final Size size;
  final String text;
  final String value;
  final Function onChanged;
  final List<String> items;
  final IconData icon;
  @override
  _RoundedDropDownState createState() => _RoundedDropDownState(this.text);
}

class _RoundedDropDownState extends State<RoundedDropDown> {
  String text;
  _RoundedDropDownState(this.text);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.6,
      decoration: new BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: Column(
        children: <Widget>[
          DropdownButton<String>(
            isExpanded: true,
            isDense: false,
            style: H2TextStyle(),
            hint: Text(
              widget.name,
              style: H2TextStyle(),
            ),
            value: this.text,
            onChanged: (String value) {
              setState(() {
                widget.onChanged(value);
                this.text = value;
              });
            },
            items: widget.items.map((String choice) {
              return DropdownMenuItem<String>(
                value: choice,
                child: H2(
                  textBody: choice,
                  color: kPrimaryDarkColor,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
