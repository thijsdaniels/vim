import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/services/collection.dart';

class PerformancesCollection<T extends Performance> extends Collection<T> {
  static PerformancesCollection of(BuildContext context) {
    return Provider.of<PerformancesCollection>(context, listen: false);
  }

  PerformancesCollection({required super.path});

  @override
  T fromFirestore(snapshot, options) {
    return Performance.fromFirestore(snapshot, options) as T;
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

  Stream<List<RoutinePerformance>> forRoutine(
    Routine routine, {
    Timestamp? before,
    int? limit,
  }) {
    var query = collection
        .where('routine.reference', isEqualTo: routine.reference)
        .where('timestamp', isLessThan: before)
        .orderBy('timestamp', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => doc.data() as RoutinePerformance).toList());
  }
}
