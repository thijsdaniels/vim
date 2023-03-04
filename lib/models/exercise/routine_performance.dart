import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/routine.dart';

class RoutinePerformance extends Performance {
  DocumentReference? _reference;

  Routine routine;

  @override
  DocumentReference? get reference => _reference;

  @override
  String get name => routine.name;

  @override
  set name(String name) {
    routine.name = name;
  }

  @override
  num get calories => routine.calories;

  @override
  set calories(num calories) {
    throw Exception("Cannot set RoutinePerformance's calories directly.");
  }

  RoutinePerformance({
    required super.timestamp,
    required this.routine,
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
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'routine': routine.toMap(),
    };
  }
}
