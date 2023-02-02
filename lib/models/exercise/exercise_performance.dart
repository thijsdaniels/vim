import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/performance.dart';

class ExercisePerformance extends Performance {
  Exercise exercise;

  @override
  String get name => exercise.name;

  @override
  num get calories => exercise.calories;

  ExercisePerformance({
    required super.timestamp,
    required this.exercise,
  }) : super(
          name: exercise.name,
          calories: exercise.calories,
        );

  static ExercisePerformance fromMap(Map<String, dynamic> map) {
    return ExercisePerformance(
      timestamp: map['timestamp'],
      exercise: Exercise.fromMap(map['exercise']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'exercise': exercise.toMap(),
    };
  }
}
