import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/performance.dart';

class ExercisePerformance extends Performance {
  DocumentReference? _reference;

  Exercise exercise;

  @override
  DocumentReference? get reference => _reference;

  @override
  String get name => exercise.name;

  ExercisePerformance({
    required super.timestamp,
    required this.exercise,
    required super.calories,
  }) : super(
          name: exercise.name,
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
      exercise: Exercise.fromMap(map['exercise']),
      calories: map['calories'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'exercise': exercise.toMap(),
      'calories': calories,
    };
  }
}
