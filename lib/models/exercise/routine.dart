import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/document.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/models/snapshot.dart';
import 'package:vim/models/user/user.dart';

class Routine extends OwnedDocument {
  List<Exercise>? _exercises;

  String name;
  // TODO: Turn this into a `List<DocumentReference<Exercise>>`.
  List<DocumentReference> exerciseReferences;

  /// TODO: Find a more sustainable way to do this, ideally via the
  /// `ExercisesCollection`.
  /// TODO: Turn this into a `Stream<List<Exercise>>` for real-time updates.
  Future<List<Exercise>> get exercises async {
    _exercises ??= (await Future.wait(
      exerciseReferences.map(
        (reference) async => (await reference
                .withConverter(
                  fromFirestore: Exercise.fromFirestore,
                  toFirestore: (exercise, _) => exercise.toMap(),
                )
                .get())
            .data()!,
      ),
    ))
        .toList();

    return Future.value(_exercises);
  }

  Routine({
    required super.user,
    required this.name,
    required this.exerciseReferences,
  });

  factory Routine.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return Routine.fromMap(snapshot.data()!)
      ..reference = snapshot.reference.withConverter<Routine>(
        fromFirestore: Routine.fromFirestore,
        toFirestore: (exercise, _) => exercise.toMap(),
      );
  }

  factory Routine.fromMap(Map<String, dynamic> map) {
    return Routine(
      user: map['user'],
      name: map['name'],
      exerciseReferences:
          List.castFrom<dynamic, DocumentReference>(map['exercises']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'name': name,
      'exercises': exerciseReferences,
    };
  }

  RoutinePerformance performance({
    required User user,
    required Timestamp timestamp,
  }) {
    return RoutinePerformance(
      user: user.reference!,
      timestamp: timestamp,
      routine: toSnapshot(),
    );
  }

  RoutineSnapshot toSnapshot() {
    return RoutineSnapshot(this);
  }
}

class RoutineSnapshot extends Snapshot<Routine> {
  RoutineSnapshot(
    super.snapshot, {
    super.reference,
  });

  static RoutineSnapshot fromMap(Map<String, dynamic> map) {
    return RoutineSnapshot(
      Routine.fromMap(map['snapshot']),
      reference: map['reference'],
    );
  }
}
