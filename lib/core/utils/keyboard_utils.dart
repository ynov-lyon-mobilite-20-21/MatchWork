import 'package:flutter/material.dart';

class KeyboardUtils {
  static void closeKeyboard({@required BuildContext context}) =>
      FocusScope.of(context).requestFocus(FocusNode());

  static bool isHidden(BuildContext context) =>
      MediaQuery.of(context).viewInsets.bottom == 0;
}
