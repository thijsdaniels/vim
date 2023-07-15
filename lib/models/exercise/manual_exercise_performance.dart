import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';

class ManualExercisePerformance extends ExercisePerformance {
  DocumentReference? _reference;

  @override
  FutureOr<num> calories;

  @override
  DocumentReference? get reference => _reference;

  @override
  String get name => exercise.snapshot.name;

  ManualExercisePerformance({
    required super.timestamp,
    required super.exercise,
    required this.calories,
  });

  static ManualExercisePerformance fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    ManualExercisePerformance exercisePerformance = fromMap(map);
    exercisePerformance._reference = snapshot.reference;

    return exercisePerformance;
  }

  static ManualExercisePerformance fromMap(Map<String, dynamic> map) {
    return ManualExercisePerformance(
      timestamp: map['timestamp'],
      exercise: ExerciseSnapshot.fromMap(map['exercise']),
      calories: map['calories'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'calories': calories,
    };
  }
}
