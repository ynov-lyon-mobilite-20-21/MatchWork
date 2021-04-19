import 'package:email_validator/email_validator.dart';
import 'package:match_work/core/utils/date_utils.dart';

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

  static String isAge(String value, [String message]) {
    int age = -1;
    try {
      age = int.parse(value);
    } catch (e) {}
    if (age < 0 || age > 150) {
      return message == null ? 'Age non valide' : message;
    }
    return null;
  }

  static String isDate(String value, [String message]) {
    if (value.isEmpty) {
      return "Veuillez entrer une date";
    }

    List<String> dates = value.trim().split('/');

    if (dates.length > 3) {
      return 'Format de date invalide';
    }

    try {
      int yearPosition = dates.length - 1;
      int year = int.parse(dates[yearPosition]);
      if (year < 1900 || year > 2100) {
        return 'Année invalide';
      }
    } catch (e) {
      return 'Format de l\'année invalide';
    }

    if (dates.length > 1) {
      try {
        int monthPosition = dates.length - 2;
        int month = int.parse(dates[monthPosition]);
        if (month < 1 || month > 12) {
          return 'Mois invalide';
        }
      } catch (e) {
        return 'Format du mois non valide';
      }
    }

    if (dates.length > 2) {
      try {
        int dayPosition = dates.length - 3;
        int day = int.parse(dates[dayPosition]);
        if (day < 1 || day > 31) {
          return 'Jour invalide';
        }
      } catch (e) {
        return 'Format du jour non valide';
      }
    }

    return null;
  }

  static String isBirthday(String value, [String message]) {
    if (value.split('/').length != 3) {
      return "Format de date invalide";
    }
    DateTime dateValue = DateUtils.getDateFromString(value);
    if (dateValue == null) {
      return "Date invalide";
    }
    String error = isDate(value);
    if(error != null)
      {
        return error;
      }
    if (!dateValue.isBefore(DateTime.now())) {
      return "La date doit être inférieure à aujourd'hui";
    }
    return null;
  }
}
