import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:vim/models/document.dart';
import 'package:vim/models/exercise/equipment.dart';
import 'package:vim/models/snapshot.dart';
import 'package:vim/services/equipments_collection_group.dart';
import 'package:vim/widgets/atoms/muscle_map/muscle_map.dart';

/// TODO: Remove in favor of relating an exercise to a set of Equipment? On
/// second thought, I no longer agree entirely. For example, take a `WeightVest`
/// as an example. This could be used both during resistance training, such as
/// dips, and during endurance training, such as running. In the case of dips,
/// you would log sets, but in the case of running, you would log a duration.
/// So, I think the `ExerciseType` is still necessary, but the `manual` type
/// should not support equipment, since the equipment is not used to calculate
/// calories.
enum ExerciseType {
  manual,
  resistance, // endurance,
  weights, // resistance,
}

class Exercise extends Document {
  ExerciseType type;
  String name;
  DocumentReference? equipmentReference;
  double bodyweightFactor;
  bool isUnilateral;
  ({
    MuscleGroup? primary,
    List<MuscleGroup> secondary,
  }) muscleGroups;

  Stream<Equipment?>? get equipment {
    return equipmentReference != null
        ? EquipmentsCollectionGroup.instance.get(equipmentReference!.path)
        : null;
  }

  Exercise({
    required this.type,
    required this.name,
    this.equipmentReference,
    this.bodyweightFactor = 0,
    this.isUnilateral = false,
    this.muscleGroups = const (
      primary: null,
      secondary: [],
    ),
  });

  factory Exercise.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return Exercise.fromMap(snapshot.data()!)
      ..reference = snapshot.reference.withConverter<Exercise>(
        fromFirestore: Exercise.fromFirestore,
        toFirestore: (exercise, _) => exercise.toMap(),
      );
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      type: ExerciseType.values.byName(map['type']),
      name: map['name'],
      equipmentReference: map['equipment'],
      bodyweightFactor: map['bodyweightFactor'] ?? 0,
      isUnilateral: map['isUnilateral'] ?? false,
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
      'equipment': equipmentReference,
      'bodyweightFactor': bodyweightFactor,
      'isUnilateral': isUnilateral,
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

class ExerciseSnapshot extends Snapshot<Exercise> {
  ExerciseSnapshot(
    super.snapshot, {
    super.reference,
  });

  static ExerciseSnapshot fromMap(Map<String, dynamic> map) {
    return ExerciseSnapshot(
      Exercise.fromMap(map['snapshot']),
      reference: map['reference'],
    );
  }
}
