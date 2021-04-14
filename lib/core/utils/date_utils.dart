import 'package:intl/intl.dart';

class DateUtils {
  static bool isToday(DateTime dateToCheck) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final aDate =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    return aDate == today;
  }

  static String getDateFormat(DateTime date) =>
      DateFormat('dd/MM/yyyy').format(date);

  static String getHourFormat(DateTime date) =>
      DateFormat('HH:mm').format(date);

  static DateTime getDateFromString(String value) {
    List dates = value.split('/');
    int year;
    int month;
    int day;

    try {
      int yearPosition = dates.length - 1;
      year = int.parse(dates[yearPosition]);
    } catch (e) {
      return null;
    }

    if (dates.length > 1) {
      try {
        int monthPosition = dates.length - 2;
        month = int.parse(dates[monthPosition]);
      } catch (e) {
        return null;
      }
    }

    if (dates.length > 2) {
      try {
        int dayPosition = dates.length - 3;
        day = int.parse(dates[dayPosition]);
      } catch (e) {
        return null;
      }
    }

    if (day != null) {
      return DateTime(year, month, day);
    }
    if (month != null) {
      return DateTime(year, month);
    }
    if (year != null) {
      return DateTime(year);
    }

    return null;
  }
}
