import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';

class WeightsExercisePerformance extends ExercisePerformance {
  DocumentReference? _reference;

  num sets;
  num repetitions;
  num weight;

  @override
  DocumentReference? get reference => _reference;

  @override
  String get name => exercise.name;

  WeightsExercisePerformance({
    required super.timestamp,
    required super.exercise,
    required super.calories,
    required this.sets,
    required this.repetitions,
    required this.weight,
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
      exercise: Exercise.fromMap(map['exercise']),
      calories: map['calories'],
      sets: map['sets'],
      repetitions: map['repetitions'],
      weight: map['weight'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'exercise': exercise.toMap(),
      'calories': calories,
      'sets': sets,
      'repetitions': repetitions,
      'weight': weight,
    };
  }
}
