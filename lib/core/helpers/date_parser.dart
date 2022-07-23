import 'package:intl/intl.dart';

class CustomDateParser {
  static String convertDateFormat(String listDate) {
    try {
      DateTime dateTime = DateTime.parse(listDate);
      DateFormat dateFormat = DateFormat('E, dd MMM yyyy -- hh:mma');
      var date = dateFormat.format(dateTime);
      return date;
    } catch (e) {
      return listDate;
    }
  }
}
