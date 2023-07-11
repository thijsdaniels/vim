import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/sets.dart';

/// TODO: Rename this class to `ResistanceExercisePerformance`.
/// TODO: Delete this class in favor of relating `Equipment` to an
/// `ExercisePerformance`.
class WeightsExercisePerformance extends ExercisePerformance {
  DocumentReference? _reference;

  Sets sets = const Sets();

  @override
  DocumentReference? get reference => _reference;

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
      exercise: ExerciseSnapshot.fromMap(map['exercise']),
      sets: Sets.fromMap(map['sets']),
      // sets: map['sets'] is! num
      //     ? Sets.fromMap(map['sets'])
      //     : Sets(
      //         List.filled(
      //           map['sets'],
      //           Set(
      //             repetitions: map['repetitions'],
      //             weight: map['weight'],
      //           ),
      //         ),
      //       ),
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
