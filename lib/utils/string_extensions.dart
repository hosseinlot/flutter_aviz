import 'package:intl/intl.dart';

// Convert String color code To Hex Color
extension DateTimeParsing on String? {
  String parseToNamedDateTime() {
// Parse the string to DateTime object
    final then = DateTime.parse(this!);

    // Calculate the difference from now
    final delta = DateTime.now().difference(then);

    // Define thresholds for different time units
    const minuteThreshold = Duration(minutes: 1);
    const hourThreshold = Duration(hours: 1);
    const dayThreshold = Duration(days: 1);

    if (delta < minuteThreshold) {
      return 'منتشر شده به تازگی';
    } else if (delta < hourThreshold) {
      return '${delta.inMinutes} دقیقه پیش';
    } else if (delta < dayThreshold) {
      return '${delta.inHours} ساعت پیش';
    } else {
      return '${delta.inDays} روز پیش';
    }
  }
}

extension PriceParsing on int? {
  String parseToPrice() {
    String result = NumberFormat.currency(locale: 'fa', symbol: '').format((this));
    return result;
  }
}
