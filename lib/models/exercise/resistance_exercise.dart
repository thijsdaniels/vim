import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/exercise.dart';

class ResistanceExercise extends Exercise {
  DocumentReference? _reference;

  Duration duration;
  num watts;

  @override
  DocumentReference? get reference => _reference;

  /// The average energy efficiency of our muscles. Studies show that the body
  /// spends about 4 joules for every joule of output. The rest is lost as heat.
  static const num efficiency = 0.24;

  Energy get energy => Energy.watts(watts, duration);

  @override
  num get calories => energy.kiloCalories / ResistanceExercise.efficiency;

  ResistanceExercise({
    required super.name,
    required this.duration,
    required this.watts,
  }) : super(calories: 0);

  static ResistanceExercise fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    ResistanceExercise exercise = fromMap(map);
    exercise._reference = snapshot.reference;

    return exercise;
  }

  static ResistanceExercise fromMap(Map<String, dynamic> map) {
    return ResistanceExercise(
      name: map['name'],
      duration: Duration(seconds: map['duration']),
      watts: map['watts'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'duration': duration.inSeconds,
      'watts': watts,
    };
  }
}

/// TODO: Move this class to a separate file.
class Energy {
  static double caloriesPerJoule = 0.238902957619;
  static double joulesPerCalorie = 1 / caloriesPerJoule;

  num _joules;

  num get joules => _joules;
  num get calories => joules * caloriesPerJoule;
  num get kiloCalories => calories / 1000;

  Energy(this._joules);

  factory Energy.joules(num joules) {
    return Energy(joules);
  }

  factory Energy.calories(num calories) {
    return Energy.joules(calories * joulesPerCalorie);
  }

  factory Energy.kiloCalories(num kiloCalories) {
    return Energy.calories(kiloCalories * 1000);
  }

  factory Energy.watts(num watts, Duration duration) {
    return Energy.joules(watts * duration.inSeconds);
  }

  Energy operator +(Energy other) {
    return Energy(joules + other.joules);
  }

  Energy operator -(Energy other) {
    return Energy(joules - other.joules);
  }

  Energy operator *(num factor) {
    return Energy(joules * factor);
  }

  Energy operator /(num factor) {
    return Energy(joules / factor);
  }
}
