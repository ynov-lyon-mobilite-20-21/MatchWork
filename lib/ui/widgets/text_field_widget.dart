import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:match_work/ui/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final Function validation;
  final bool isObscureText;
  final TextInputType inputType;
  final Color color;
  final String helperText;
  final bool automaticFormatDate;

  TextFieldWidget(
      {Key key,
      this.controller,
      this.validation,
      this.label,
      this.isObscureText = false,
      this.inputType = TextInputType.text,
      this.color,
      this.helperText,
      this.automaticFormatDate = false})
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
      inputFormatters:
          widget.automaticFormatDate ? [DateTextFormatter()] : null,
      style: TextStyle(color: color),
      decoration: InputDecoration(
        helperText: widget.helperText,
        errorMaxLines: 5,
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

class DateTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    //this fixes backspace bug
    if (oldValue.text.length >= newValue.text.length) {
      return newValue;
    }

    var dateText = _addSeperators(newValue.text, '/');
    return newValue.copyWith(
        text: dateText, selection: updateCursorPosition(dateText));
  }

  String _addSeperators(String value, String seperator) {
    value = value.replaceAll('/', '');
    var newString = '';
    for (int i = 0; i < value.length; i++) {
      newString += value[i];
      if (i == 1) {
        newString += seperator;
      }
      if (i == 3) {
        newString += seperator;
      }
    }
    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}
