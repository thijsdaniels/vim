import 'dart:async';

import 'package:vim/models/exercise/energy.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';

/// TODO: Rename this class to `EnduranceExercisePerformance`.
/// TODO: If possible, delete this class in favor of relating `Equipment` to an
/// `ExercisePerformance`.
class ResistanceExercisePerformance extends ExercisePerformance {
  Duration duration;
  num watts;

  /// The average energy efficiency of our muscles. Studies show that the body
  /// spends about 4 joules for every joule of output. The rest is lost as heat.
  /// TechnoGym apparently disagrees with those studies, as their app reports
  /// calories corresponding to an efficiency of only 15.3 percent. I will use
  /// their approximation for now, since I have been using their app so far, but
  /// I will likely switch when I've read a bit more about the subject.
  static const num efficiency = 0.153; // 0.24;

  Energy get energy => Energy.watts(watts, duration);

  @override
  FutureOr<num> get calories =>
      energy.kiloCalories / ResistanceExercisePerformance.efficiency;

  ResistanceExercisePerformance({
    required super.timestamp,
    required super.exercise,
    required this.duration,
    required this.watts,
  });

  static ResistanceExercisePerformance fromMap(Map<String, dynamic> map) {
    return ResistanceExercisePerformance(
      timestamp: map['timestamp'],
      exercise: ExerciseSnapshot.fromMap(map['exercise']),
      duration: Duration(seconds: map['duration']),
      watts: map['watts'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'duration': duration.inSeconds,
      'watts': watts,
    };
  }
}
