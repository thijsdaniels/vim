import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:vim/extensions/date_time.dart';

class DateModel extends ChangeNotifier {
  DateTime _date = DateTime.now().startOfDay();

  DateTime get date => _date;

  Timestamp get timestamp {
    DateTime now = DateTime.now();
    DateTime startOfToday = now.startOfDay();
    DateTime endOfToday = now.startOfDay();

    if (date.isBefore(startOfToday)) {
      return Timestamp.fromDate(date.endOfDay());
    } else if (date.isAfter(endOfToday)) {
      return Timestamp.fromDate(date);
    } else {
      return Timestamp.fromDate(date.withTimeOf(now));
    }
  }

  void set(DateTime dateTime) {
    _date = dateTime.startOfDay();
    notifyListeners();
  }

  void today() {
    set(DateTime.now());
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
