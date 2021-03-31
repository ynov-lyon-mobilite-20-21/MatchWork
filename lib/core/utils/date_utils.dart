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
}
