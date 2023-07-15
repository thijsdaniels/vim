import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/extensions/sets.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/set.dart';

/// TODO: Rename this class to `ResistanceExercisePerformance`.
/// TODO: Delete this class in favor of relating `Equipment` to an
/// `ExercisePerformance`.
class WeightsExercisePerformance extends ExercisePerformance {
  DocumentReference? _reference;

  List<Set> sets = [];

  @override
  DocumentReference? get reference => _reference;

  @override
  FutureOr<num> get calories => sets.calories;

  WeightsExercisePerformance({
    required super.timestamp,
    required super.exercise,
    required this.sets,
  });

  static WeightsExercisePerformance fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    WeightsExercisePerformance exercisePerformance = fromMap(map);
    exercisePerformance._reference = snapshot.reference;

    return exercisePerformance;
  }

  static WeightsExercisePerformance fromMap(Map<String, dynamic> map) {
    return WeightsExercisePerformance(
      timestamp: map['timestamp'],
      exercise: ExerciseSnapshot.fromMap(map['exercise']),
      sets: Sets.fromMap(map['sets']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'sets': sets.toMap(),
    };
  }
}
