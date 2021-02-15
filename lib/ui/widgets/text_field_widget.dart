import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function validation;
  final bool isObscureText;
  final TextInputType inputType;

  TextFieldWidget(
      {Key key,
      this.controller,
      this.validation,
      this.label,
      this.isObscureText = false,
      this.inputType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: label,
      ),
      validator: validation,
      obscureText: isObscureText,
      controller: controller,
      keyboardType: inputType,
    );
  }
}
