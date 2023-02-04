import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/energy.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';

class ResistanceExercisePerformance extends ExercisePerformance {
  DocumentReference? _reference;

  Duration duration;
  num watts;

  @override
  DocumentReference? get reference => _reference;

  @override
  String get name => exercise.name;

  /// The average energy efficiency of our muscles. Studies show that the body
  /// spends about 4 joules for every joule of output. The rest is lost as heat.
  static const num efficiency = 0.24;

  Energy get energy => Energy.watts(watts, duration);

  @override
  num get calories =>
      energy.kiloCalories / ResistanceExercisePerformance.efficiency;

  ResistanceExercisePerformance({
    required super.timestamp,
    required super.exercise,
    required this.duration,
    required this.watts,
  }) : super(
          calories: 0,
        );

  static ResistanceExercisePerformance fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    ResistanceExercisePerformance exercisePerformance = fromMap(map);
    exercisePerformance._reference = snapshot.reference;

    return exercisePerformance;
  }

  static ResistanceExercisePerformance fromMap(Map<String, dynamic> map) {
    return ResistanceExercisePerformance(
      timestamp: map['timestamp'],
      exercise: Exercise.fromMap(map['exercise']),
      duration: Duration(seconds: map['duration']),
      watts: map['watts'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'exercise': exercise.toMap(),
      'duration': duration.inSeconds,
      'watts': watts,
    };
  }
}
