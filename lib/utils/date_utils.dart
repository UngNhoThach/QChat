import 'package:intl/intl.dart';

class date_utils {
  static String readTimestamp(String time) {
    if (time.isEmpty) {
      return '';
    } else {
      var now = DateTime.now();
      var format = DateFormat('HH:mm a');
      var date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
      var diff = now.difference(date);
      String formattedTime = ' ';
      if (diff.inSeconds <= 0 ||
          diff.inSeconds > 0 && diff.inMinutes == 0 ||
          diff.inMinutes > 0 && diff.inHours == 0 ||
          diff.inHours > 0 && diff.inDays == 0) {
        formattedTime = format.format(date);
      } else if (diff.inDays > 0 && diff.inDays < 7) {
        if (diff.inDays == 1) {
          formattedTime = diff.inDays.toString() + ' DAY AGO';
        } else {
          formattedTime = diff.inDays.toString() + ' DAYS AGO';
        }
      } else {
        if (diff.inDays == 7) {
          formattedTime = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
        } else {
          formattedTime = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
        }
      }
      return formattedTime;
    }
  }

  static String readTimestampToYear(String time) {
    if (time.isEmpty) {
      return '';
    } else {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
      String day = dateTime.day.toString().padLeft(2, '0');
      String month = dateTime.month.toString().padLeft(2, '0');
      String year = dateTime.year.toString();
      return '$day-$month-$year';
    }
  }
}
