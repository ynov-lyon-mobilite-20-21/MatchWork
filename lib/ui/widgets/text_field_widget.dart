import 'package:flutter/material.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final Function validation;
  final bool isObscureText;
  final TextInputType inputType;
  final Color color;
  final helperText;

  TextFieldWidget(
      {Key key,
      this.controller,
      this.validation,
      this.label,
      this.isObscureText = false,
      this.inputType = TextInputType.text,
      this.color,
      this.helperText})
      : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Provider.of<ThemeProvider>(context).getTheme();
    Color color =
        widget.color != null ? widget.color : (theme.textTheme.subtitle1.color);

    return TextFormField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        helperText: widget.helperText,
        fillColor: color,
        focusColor: color,
        hoverColor: color,
        labelText: widget.label,
        isDense: true,
        labelStyle: TextStyle(color: color),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: color ?? Theme.of(context)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: color ?? Theme.of(context)),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: color ?? Theme.of(context)),
        ),
      ),
      validator: widget.validation,
      obscureText: widget.isObscureText,
      controller: widget.controller,
      keyboardType: widget.inputType,
    );
  }
}
