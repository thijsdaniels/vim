import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/performances.dart';
import 'package:vim/models/exercise/routine.dart';

class RoutinePerformance extends Performance {
  DocumentReference? _reference;
  Routine routine;
  Map<String, ExercisePerformance?> performances;

  @override
  DocumentReference? get reference => _reference;

  @override
  String get name => routine.name;

  @override
  set name(String name) {
    routine.name = name;
  }

  @override
  num get calories {
    /// TODO: Prepending the 0 element is an ugly way to make sure there is at
    /// least one element, which is necessary for reduce.. Find a way to make
    /// this prettier.
    return [
      0,
      ...performances.values.map((performance) => performance?.calories ?? 0)
    ].reduce((total, calories) => total + calories);
  }

  @override
  set calories(num calories) {
    throw Exception("Cannot set RoutinePerformance's calories directly.");
  }

  RoutinePerformance({
    required super.timestamp,
    required this.routine,
    this.performances = const {},
  }) : super(name: "", calories: 0);

  static RoutinePerformance fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    RoutinePerformance routinePerformance = fromMap(map);
    routinePerformance._reference = snapshot.reference;

    return routinePerformance;
  }

  static RoutinePerformance fromMap(Map<String, dynamic> map) {
    return RoutinePerformance(
      timestamp: map['timestamp'],
      routine: Routine.fromMap(map['routine']),
      performances: (map['performances'] as Map<String, dynamic>).map(
        (key, performance) => MapEntry(
          key,
          exercisePerformanceFromMap(performance),
        ),
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'routine': routine.toMap(),
      'performances': performances.map(
        (key, performance) => MapEntry(
          key,
          performance?.toMap(),
        ),
      ),
    };
  }
}
