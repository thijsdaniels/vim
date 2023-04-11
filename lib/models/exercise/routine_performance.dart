import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/resistance_exercise_performance.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/models/exercise/weights_exercise_performance.dart';

class RoutinePerformance extends Performance {
  DocumentReference? _reference;

  Routine routine;

  // TODO: Move this to a service.
  CollectionReference<ExercisePerformance>? get _performances => _reference !=
          null
      ? FirebaseFirestore.instance
          .collection('${_reference!.path}/performances')
          .withConverter(
              fromFirestore: (snapshot, _) {
                Map<String, dynamic> data = snapshot.data()!;

                switch (ExerciseType.values.byName(data['exercise']['type'])) {
                  case ExerciseType.manual:
                    return ExercisePerformance.fromSnapshot(snapshot);
                  case ExerciseType.resistance:
                    return ResistanceExercisePerformance.fromSnapshot(snapshot);
                  case ExerciseType.weights:
                    return WeightsExercisePerformance.fromSnapshot(snapshot);
                }
              },
              toFirestore: (performance, options) => performance.toMap())
      : null;

  @override
  DocumentReference? get reference => _reference;

  @override
  String get name => routine.name;

  Map<String, DocumentReference> performanceReferences;

  Stream<List<ExercisePerformance>>? get performances {
    return _performances?.snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) => doc.data()).toList();
      },
    );
  }

  @override
  Future<num> get calories async {
    return await performances!
        .map(
          (performances) => [
            /// TODO: I prepend a 0, because .reduce() throws an error when
            /// there are no entries. Find a prettier solution to this.
            Future(() => 0),
            ...performances.map((performance) => performance.calories)
          ].reduce((total, calories) async => await total + await calories),
        )
        .first;
  }

  RoutinePerformance({
    required super.timestamp,
    required this.routine,
    Map<String, DocumentReference>? performanceReferences,
  })  : performanceReferences = performanceReferences ?? {},
        super(name: "", calories: 0);

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
      performanceReferences:
          map['performances'].cast<String, DocumentReference>(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'routine': routine.toMap(),
      'performances': performanceReferences,
    };
  }

  Future<DocumentReference> addPerformance(
      int exerciseIndex, ExercisePerformance performance) async {
    DocumentReference reference = await _performances!.add(performance);

    performanceReferences[exerciseIndex.toString()] = reference;
    _reference?.update(toMap());

    return reference;
  }

  Future<void> updatePerformance(ExercisePerformance performance) async {
    assert(performance.reference != null);
    return _performances!.doc(performance.reference!.id).set(performance);
  }

  Future<void> deletePerformance(ExercisePerformance performance) async {
    assert(performance.reference != null);

    await _performances!.doc(performance.reference!.id).delete();
    performanceReferences.removeWhere(
      (key, value) => value.id == performance.reference!.id,
    );

    _reference?.update(toMap());

    return;
  }
}
