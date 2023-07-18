import 'dart:async';

import 'package:vim/extensions/sets.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/set.dart';

/// TODO: Delete this class in favor of relating `Equipment` to an
/// `ExercisePerformance`.
class ResistanceExercisePerformance extends ExercisePerformance {
  List<Set> sets = [];

  @override
  FutureOr<num> get calories => sets.calories;

  ResistanceExercisePerformance({
    required super.timestamp,
    required super.exercise,
    required this.sets,
  });

  static ResistanceExercisePerformance fromMap(Map<String, dynamic> map) {
    return ResistanceExercisePerformance(
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
