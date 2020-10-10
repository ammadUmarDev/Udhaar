import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udhaar/components/text_field_container.dart';
import '../constants.dart';
import 'h2.dart';

class RoundedImagePicker extends StatefulWidget {
  final String hintText;
  final ValueChanged<File> onPicked;
  RoundedImagePicker({this.hintText = "Pick an Image", this.onPicked});
  @override
  _RoundedImagePickerState createState() => _RoundedImagePickerState();
}

class _RoundedImagePickerState extends State<RoundedImagePicker> {
  //File image;
  final picker = ImagePicker();
  ImageSource src = ImageSource.gallery;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: this.src);

    setState(() {
      widget.onPicked(File(pickedFile.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: FlatButton(
        onPressed: getImage,
        child: H2(
          textBody: widget.hintText,
          color: kPrimaryDarkColor,
        ),
      ),
      //child: Icon(Icons.add_a_photo),
    );
  }
}
