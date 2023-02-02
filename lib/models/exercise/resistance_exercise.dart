import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/exercise.dart';

const double caloriesPerJoule = 4.1868;

class ResistanceExercise extends Exercise {
  DocumentReference? _reference;

  Duration duration;
  num watts;

  @override
  DocumentReference? get reference => _reference;

  num get joules => duration.inSeconds * watts;

  /// TODO: This calculation seems to be incorrect, because it says that a
  /// performance of 10 minutes at 90 watts is only 13 kcal and this should be
  /// closer to 73 kcal.
  @override
  num get calories => joules / 4184;

  ResistanceExercise({
    required super.name,
    required this.duration,
    required this.watts,
  }) : super(
          calories: 0,
        );

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
