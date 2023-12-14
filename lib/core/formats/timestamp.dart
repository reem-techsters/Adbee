import 'package:intl/intl.dart';

String convertTimestampToFormattedDate(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  String formattedDate = '';

  DateTime now = DateTime.now();

  if (dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day) {
    String formattedTime = DateFormat.jm().format(dateTime);
    formattedDate = "Today, $formattedTime";
  } else if (dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day - 1) {
    String formattedTime = DateFormat.jm().format(dateTime);
    formattedDate = "Yesterday, $formattedTime";
  } else if (dateTime.isBefore(now.subtract(Duration(days: 1))) &&
      dateTime.isAfter(now.subtract(Duration(days: 5)))) {
    String formattedDayOfWeek = DateFormat('EEEE').format(dateTime);
    String formattedTime = DateFormat.jm().format(dateTime);
    formattedDate = "$formattedDayOfWeek, $formattedTime";
  } else {
    String formattedDatePart = DateFormat('MMM d, y').format(dateTime);
    String formattedTimePart = DateFormat.jm().format(dateTime);
    formattedDate = "$formattedDatePart $formattedTimePart";
  }

  return formattedDate;
}
