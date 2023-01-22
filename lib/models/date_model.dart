import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DateModel extends ChangeNotifier {
  DateTime _date = getToday();

  DateTime get date => _date;
  Timestamp get timestamp => Timestamp.fromDate(date);

  void set(DateTime date) {
    _date = date;
    notifyListeners();
  }

  void today() {
    set(getToday());
  }

  void subtract(int days) {
    set(_date.subtract(const Duration(days: 1)));
  }

  void add(int days) {
    set(_date.add(const Duration(days: 1)));
  }

  void previous() {
    subtract(1);
  }

  void next() {
    add(1);
  }
}

DateTime getToday() {
  DateTime now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}
