import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:vim/models/document.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/widgets/atoms/muscle_map/muscle_map.dart';

// TODO: Remove in favor of relating an exercise to a set of Equipment.
enum ExerciseType {
  manual,
  resistance,
  weights,
}

class Exercise extends Document {
  DocumentReference? _reference;
  ExerciseType type;
  String name;
  // List<Equipment> equipment;
  ({
    MuscleGroup? primary,
    List<MuscleGroup> secondary,
  }) muscleGroups;

  @override
  DocumentReference? get reference => _reference;

  Exercise({
    required this.type,
    required this.name,
    this.muscleGroups = const (
      primary: null,
      secondary: [],
    ),
  });

  static Exercise fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    Exercise exercise = fromMap(map);
    exercise._reference = snapshot.reference;

    return exercise;
  }

  static Exercise fromMap(Map<String, dynamic> map) {
    return Exercise(
      type: ExerciseType.values.byName(map['type']),
      name: map['name'],
      muscleGroups: (
        primary: map['muscleGroups']?['primary'] != null
            ? MuscleGroup.values.byName(map['muscleGroups']?['primary'])
            : null,
        secondary: List.castFrom<dynamic, MuscleGroup>(
          (map['muscleGroups']?['secondary'] ?? [])
              .map((muscleGroup) => MuscleGroup.values.byName(muscleGroup))
              .toList(),
        )
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type.name,
      'name': name,
      'muscleGroups': {
        'primary': muscleGroups.primary != null
            ? describeEnum(muscleGroups.primary!)
            : null,
        'secondary': muscleGroups.secondary
            .map((muscleGroup) => describeEnum(muscleGroup)),
      },
    };
  }

  ExerciseSnapshot toSnapshot() {
    return ExerciseSnapshot(this);
  }
}
