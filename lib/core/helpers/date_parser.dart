import 'package:intl/intl.dart';

class CustomDateParser {
  static String convertDateFormat(String listDate) {
    DateTime dateTime = DateTime.parse(listDate);
    DateFormat dateFormat = DateFormat('E, dd MMM yyyy -- hh:mma');
    return dateFormat.format(dateTime);
  }
}
