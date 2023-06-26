import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  DateTime startOfDay() => withTime(0, 0, 0, 0, 0);

  DateTime endOfDay() => withTime(23, 59, 59);

  DateTime withTimeOf(DateTime other) => withTime(
        other.hour,
        other.minute,
        other.second,
        other.millisecond,
        other.microsecond,
      );

  DateTime withTime(
    int hour, [
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  ]) =>
      DateTime(
        year,
        month,
        day,
        hour,
        minute,
        second,
        millisecond,
        microsecond,
      );

  DateTime clamp(DateTime start, DateTime end) {
    assert(end.isAfter(start));

    if (isBefore(start)) {
      return start;
    } else if (isAfter(end)) {
      return end;
    }

    return this;
  }

  bool isToday() {
    return isAtSameDayAs(DateTime.now());
  }

  bool isTomorrow() {
    return isAtSameDayAs(DateTime.now().add(const Duration(days: 1)));
  }

  bool isYesterday() {
    return isAtSameDayAs(DateTime.now().add(const Duration(days: -1)));
  }

  bool isAtSameDayAs(DateTime other) {
    return other.year == year && other.month == month && other.day == day;
  }

  String toDateTimeString() {
    return '${toDateString()} ${toTimeString()}';
  }

  String toDateString() {
    return DateFormat.yMMMMd('en_US').format(this);
  }

  String toTimeString() {
    return DateFormat.Hm('en_US').format(this);
  }
}
