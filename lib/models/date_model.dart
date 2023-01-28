import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:vim/extensions/date_time.dart';

class DateModel extends ChangeNotifier {
  DateTime _date = DateTime.now().toDate();

  DateTime get date => _date;
  Timestamp get timestamp => Timestamp.fromDate(date);

  void set(DateTime dateTime) {
    _date = dateTime.toDate();
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
