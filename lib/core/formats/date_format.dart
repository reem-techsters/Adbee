import 'package:intl/intl.dart';

String formatDateTime(String inputDateTimeStr) {
  // Parse the input string into a DateTime object
  DateTime inputDateTime = DateTime.parse(inputDateTimeStr);

  // Format the DateTime object to the desired format (day month year)
  String formattedDate = DateFormat('dd MMM yyyy').format(inputDateTime);

  return formattedDate;
}

String formatDob(String inputDateTimeStr) {
  // Parse the input string into a DateTime object
  DateTime inputDateTime = DateTime.parse(inputDateTimeStr);

  // Format the DateTime object to the desired format (year/month/day)
  String formattedDate = DateFormat('yyyy/MM/dd').format(inputDateTime);

  return formattedDate;
}
