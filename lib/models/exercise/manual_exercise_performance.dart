import 'dart:async';

import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';

class ManualExercisePerformance extends ExercisePerformance {
  @override
  FutureOr<num> calories;

  @override
  String get name => exercise.snapshot.name;

  ManualExercisePerformance({
    required super.timestamp,
    required super.exercise,
    required this.calories,
  });

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
