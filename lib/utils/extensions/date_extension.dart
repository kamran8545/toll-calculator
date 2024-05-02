import 'package:intl/intl.dart';

extension DateExtension on String {
  static String defaultFormat = 'yyyy-MM-dd HH:mm:ss.SSS';
  static String requiredFormat = 'dd/MM/yyyy hh:mm:ss a';

  String convertToGeneralFormat(){
    DateFormat dateFormat = DateFormat(defaultFormat);
    DateTime dateTime = dateFormat.parse(this);
    return DateFormat(requiredFormat).format(dateTime);
  }

  DateTime parseDate(){
    DateFormat dateFormat = DateFormat(requiredFormat);
    return dateFormat.parse(this);
  }
}
