extension DateExtension on DateTime {
  DateTime toDate() => DateTime(year, month, day);

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
}
