import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/services/performances_service.dart';

class RoutinePerformance extends Performance {
  DocumentReference? _reference;

  RoutineSnapshot routine;
  Map<String, DocumentReference> performanceReferences;

  PerformancesService<ExercisePerformance>? get performancesService =>
      _reference != null
          ? PerformancesService(
              path: '${_reference!.path}/performances',
            )
          : null;

  @override
  DocumentReference? get reference => _reference;

  @override
  String get name => routine.snapshot.name;

  Stream<List<ExercisePerformance>>? get performances {
    return performancesService?.all();
  }

  @override
  Future<num> get calories async {
    return await performances!
        .map(
          (performances) => [
            /// TODO: I prepend a 0, because .reduce() throws an error when
            /// there are no entries. Find a prettier solution to this.
            Future.value(0),
            ...performances.map((performance) => performance.calories)
          ].reduce((total, calories) async => await total + await calories),
        )
        .first;
  }

  RoutinePerformance({
    required super.timestamp,
    required this.routine,
    Map<String, DocumentReference>? performanceReferences,
  }) : performanceReferences = performanceReferences ?? {};

  @override
  Future<void> onDelete() async {
    /// Delete a `RoutinePerformance`'s nested performances.
    await Future.wait(
      (await performancesService!.all().first)
          .map((performance) => performance.reference!.delete()),
    );
  }

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
      routine: RoutineSnapshot.fromMap(map['routine']),
      performanceReferences:
          map['performances'].cast<String, DocumentReference>(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'routine': routine.toMap(),
      'performances': performanceReferences,
    };
  }

  Future<DocumentReference> addPerformance(
    int exerciseIndex,
    ExercisePerformance performance,
  ) async {
    assert(performancesService != null);

    DocumentReference reference =
        await performancesService!.create(performance);

    performanceReferences[exerciseIndex.toString()] = reference;
    _reference?.update(toMap());

    return reference;
  }

  Future<void> updatePerformance(ExercisePerformance performance) async {
    assert(performancesService != null);
    return performancesService!.update(performance);
  }

  Future<void> deletePerformance(ExercisePerformance performance) async {
    assert(performancesService != null);

    await performancesService!.delete(performance);

    performanceReferences.removeWhere(
      (key, value) => value.id == performance.reference!.id,
    );
    _reference?.update(toMap());

    return;
  }
}
