import 'package:vim/models/exercise/endurance_exercise_performance.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/manual_exercise_performance.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/resistance_exercise_performance.dart';

abstract class ExercisePerformance extends Performance {
  ExerciseSnapshot exercise;

  @override
  String get name => exercise.snapshot.name;

  @override
  num get calories;

  ExercisePerformance({
    required super.user,
    required super.timestamp,
    required this.exercise,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'exercise': exercise.toMap(),
    };
  }

  static ExercisePerformance fromMap(Map<String, dynamic> map) {
    switch (ExerciseType.values.byName(map['exercise']['snapshot']['type'])) {
      case ExerciseType.manual:
        return ManualExercisePerformance.fromMap(map);
      case ExerciseType.resistance:
        return EnduranceExercisePerformance.fromMap(map);
      case ExerciseType.weights:
        return ResistanceExercisePerformance.fromMap(map);
    }
  }
}
