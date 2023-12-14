import 'package:intl/intl.dart';

String formatTimeString(String timeString) {
  // Parse the input time string
  DateTime time = DateFormat("HH:mm:ss").parse(timeString);

  // Format the time to a more human-readable format
  String formattedTime = DateFormat("h:mm a").format(time);

  return formattedTime;
}
