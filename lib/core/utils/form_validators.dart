import 'package:email_validator/email_validator.dart';

class FormValidators {
  static String isNotEmpty(String value, [String message]) {
    if (value.isEmpty) {
      return message == null ? 'Veuillez entrer une valeur' : message;
    }
    return null;
  }

  static String isEmail(String value, [String message]) {
    if (!EmailValidator.validate(value)) {
      return message == null ? 'Adresse email non valide' : message;
    }
    return null;
  }

  static String isStrongPassword(String value, [String message]) {
    if (value.length < 7) {
      return message == null ? 'Mot de passe trop faible' : message;
    }
    return null;
  }

  static String isSameValue(String value, String confirmation,
      [String message]) {
    if (value != confirmation) {
      return message == null ? 'Les valeurs ne correspondent pas' : message;
    }
    return null;
  }
}
