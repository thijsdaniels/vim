import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/resistance_exercise_performance.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/models/exercise/weights_exercise_performance.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/service.dart';

class PerformancesService extends Service<Performance> {
  static PerformancesService of(BuildContext context) {
    return Provider.of<PerformancesService>(context, listen: false);
  }

  PerformancesService(User user)
      : super(path: 'users/${user.reference!.id}/performances');

  @override
  Performance fromFirestore(snapshot, options) {
    Map<String, dynamic> data = snapshot.data()!;

    /// TODO: Move this logic into the `Performance.fromSnapshot` function?
    if (data['exercise'] != null) {
      switch (
          ExerciseType.values.byName(data['exercise']['snapshot']['type'])) {
        case ExerciseType.manual:
          return ExercisePerformance.fromSnapshot(snapshot);
        case ExerciseType.resistance:
          return ResistanceExercisePerformance.fromSnapshot(snapshot);
        case ExerciseType.weights:
          return WeightsExercisePerformance.fromSnapshot(snapshot);
      }
    } else if (data['routine'] != null) {
      return RoutinePerformance.fromSnapshot(snapshot);
    } else {
      return Performance.fromSnapshot(snapshot);
    }
  }

  Stream<List<Performance>> forDate(DateTime date) {
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
        .map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }

  Stream<List<ExercisePerformance>> forExercise(
    Exercise exercise, {
    Timestamp? before,
    int? limit,
  }) {
    var query = collection
        .where('exercise.reference', isEqualTo: exercise.reference)
        .where('timestamp', isLessThan: before)
        .orderBy('timestamp', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => doc.data() as ExercisePerformance)
              .toList(),
        );
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

    return query.snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => doc.data() as RoutinePerformance)
              .toList(),
        );
  }
}
