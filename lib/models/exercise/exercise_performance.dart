import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/resistance_exercise.dart';
import 'package:vim/models/exercise/weights_exercise.dart';

class ExercisePerformance extends Performance {
  DocumentReference? _reference;

  Exercise exercise;

  @override
  DocumentReference? get reference => _reference;

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

  static ExercisePerformance fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    ExercisePerformance exercisePerformance = fromMap(map);
    exercisePerformance._reference = snapshot.reference;

    return exercisePerformance;
  }

  static ExercisePerformance fromMap(Map<String, dynamic> map) {
    return ExercisePerformance(
      timestamp: map['timestamp'],
      exercise: map['exercise']['duration'] != null
          ? ResistanceExercise.fromMap(map['exercise'])
          : map['exercise']['weight'] != null
              ? WeightsExercise.fromMap(map['exercise'])
              : Exercise.fromMap(map['exercise']),
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
