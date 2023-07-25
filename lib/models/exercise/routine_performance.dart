import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/services/performances_collection.dart';

class RoutinePerformance extends Performance {
  RoutineSnapshot routine;
  // TODO: Turn this into a `Map<String, DocumentReference<ExercisePerformance>>`.
  Map<String, DocumentReference> performanceReferences;

  PerformancesCollection<ExercisePerformance>? get performancesCollection =>
      reference != null
          ? PerformancesCollection<ExercisePerformance>(
              path: '${reference!.path}/performances',
            )
          : null;

  @override
  String get name => routine.snapshot.name;

  Stream<List<ExercisePerformance>>? get performances {
    return performancesCollection?.all();
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
    required super.user,
    required super.timestamp,
    required this.routine,
    Map<String, DocumentReference>? performanceReferences,
  }) : performanceReferences = performanceReferences ?? {};

  @override
  Future<void> onDelete() async {
    /// Delete a `RoutinePerformance`'s nested performances.
    await Future.wait(
      (await performancesCollection!.all().first)
          .map((performance) => performance.reference!.delete()),
    );
  }

  static RoutinePerformance fromMap(Map<String, dynamic> map) {
    return RoutinePerformance(
      user: map['user'],
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
    assert(performancesCollection != null);

    DocumentReference exercisePerformanceReference =
        await performancesCollection!.create(performance);

    performanceReferences[exerciseIndex.toString()] =
        exercisePerformanceReference;

    reference?.update(toMap());

    return exercisePerformanceReference;
  }

  Future<void> updatePerformance(ExercisePerformance performance) async {
    assert(performancesCollection != null);
    return performancesCollection!.update(performance);
  }

  Future<void> deletePerformance(ExercisePerformance performance) async {
    assert(performancesCollection != null);

    await performancesCollection!.delete(performance);

    performanceReferences.removeWhere(
      (key, value) => value.id == performance.reference!.id,
    );
    reference?.update(toMap());

    return;
  }
}
