import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/exercise.dart';

class WeightsExercise extends Exercise {
  DocumentReference? _reference;

  num sets;
  num repetitions;
  num weight;

  @override
  DocumentReference? get reference => _reference;

  WeightsExercise({
    required super.name,
    required super.calories,
    required this.sets,
    required this.repetitions,
    required this.weight,
  });

  static WeightsExercise fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    WeightsExercise exercise = fromMap(map);
    exercise._reference = snapshot.reference;

    return exercise;
  }

  static WeightsExercise fromMap(Map<String, dynamic> map) {
    return WeightsExercise(
      name: map['name'],
      calories: map['calories'],
      sets: map['sets'],
      repetitions: map['repetitions'],
      weight: map['weight'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'calories': calories,
      'sets': sets,
      'repetitions': repetitions,
      'weight': weight,
    };
  }
}
