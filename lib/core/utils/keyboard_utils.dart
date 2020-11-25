import 'package:flutter/material.dart';

class KeyboardUtils {
  /// Close keyboard
  static void closeKeyboard({@required BuildContext context}) =>
      FocusScope.of(context).requestFocus(FocusNode());
}
