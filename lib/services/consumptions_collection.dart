import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/services/collection.dart';

class ConsumptionsCollection<T extends Consumption> extends Collection<T> {
  static ConsumptionsCollection of(BuildContext context) {
    return Provider.of<ConsumptionsCollection>(context, listen: false);
  }

  ConsumptionsCollection({required super.path});

  @override
  T fromFirestore(snapshot, options) {
    return Consumption.fromFirestore(snapshot, options) as T;
  }

  Stream<List<T>> forDate(DateTime date) {
    DateTime today = DateTime(date.year, date.month, date.day);
    DateTime tomorrow = today.add(const Duration(days: 1));

    return collection
        .where(
          'timestamp',
          isGreaterThanOrEqualTo: Timestamp.fromDate(today),
          isLessThan: Timestamp.fromDate(tomorrow),
        )
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
