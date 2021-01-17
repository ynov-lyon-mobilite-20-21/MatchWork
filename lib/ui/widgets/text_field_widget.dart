import 'package:flutter/material.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Color color;
  final Function validation;
  final bool isObscureText;
  final TextInputType inputType;
  final double height;
  final double width;

  TextFieldWidget(
      {Key key,
      this.controller,
      this.validation,
      this.color,
      this.label,
      this.isObscureText = false,
      this.inputType = TextInputType.text,
      this.height = 40.0,
      this.width = 250.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
          child: Text(
            label,
            style: Provider.of<ThemeProvider>(context)
                .getTheme()
                .textTheme
                .bodyText1,
          ),
        ),
        Container(
          height: height,
          width: width,
          child: Material(
            elevation: 10.0,
            borderRadius: BorderRadius.circular(height / 2),
            child: TextFormField(
              validator: validation,
              obscureText: isObscureText,
              textAlign: TextAlign.center,
              controller: controller,
              keyboardType: inputType,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(height / 2),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                fillColor: color,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
