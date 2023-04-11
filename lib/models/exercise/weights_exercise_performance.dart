import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/set.dart';
import 'package:vim/models/exercise/sets.dart';

class WeightsExercisePerformance extends ExercisePerformance {
  DocumentReference? _reference;

  Sets sets = const Sets();

  @override
  DocumentReference? get reference => _reference;

  @override
  String get name => exercise.name;

  @override
  Future<num> get calories => Future(() => sets.calories);

  WeightsExercisePerformance({
    required super.timestamp,
    required super.exercise,
    required this.sets,
  }) : super(calories: 0);

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
      sets: map['sets'] is! num
          ? Sets.fromMap(map['sets'])
          : Sets(
              List.filled(
                map['sets'],
                Set(
                  repetitions: map['repetitions'],
                  weight: map['weight'],
                ),
              ),
            ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'exercise': exercise.toMap(),
      'sets': sets.toMap(),
    };
  }
}
