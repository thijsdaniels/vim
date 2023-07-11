import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/resistance_exercise_performance.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/models/exercise/weights_exercise_performance.dart';
import 'package:vim/services/collection_group.dart';

class PerformancesCollectionGroup extends CollectionGroup<Performance> {
  static PerformancesCollectionGroup instance = PerformancesCollectionGroup();

  PerformancesCollectionGroup() : super(path: 'performances');

  /// TODO: This duplicates code from the `PerformancesService` class.
  /// TODO: Move this logic into the `Performance.fromSnapshot` function?
  @override
  Performance fromFirestore(snapshot, options) {
    Map<String, dynamic> data = snapshot.data()!;

    if (data['exercise'] != null) {
      switch (
          ExerciseType.values.byName(data['exercise']['snapshot']['type'])) {
        case ExerciseType.manual:
          return ExercisePerformance.fromSnapshot(snapshot);
        case ExerciseType.resistance:
          return ResistanceExercisePerformance.fromSnapshot(snapshot);
        case ExerciseType.weights:
          return WeightsExercisePerformance.fromSnapshot(snapshot);
      }
    } else if (data['routine'] != null) {
      return RoutinePerformance.fromSnapshot(snapshot);
    } else {
      return Performance.fromSnapshot(snapshot);
    }
  }

  Stream<List<ExercisePerformance>> forExercise(
    Exercise exercise, {
    Timestamp? before,
    int? limit,
  }) {
    var query = collectionGroup
        .where('exercise.reference', isEqualTo: exercise.reference)
        .where('timestamp', isLessThan: before)
        .orderBy('timestamp', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => doc.data() as ExercisePerformance)
              .toList(),
        );
  }

  Stream<List<RoutinePerformance>> forRoutine(
    Routine routine, {
    Timestamp? before,
    int? limit,
  }) {
    var query = collectionGroup
        .where('routine.reference', isEqualTo: routine.reference)
        .where('timestamp', isLessThan: before)
        .orderBy('timestamp', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => doc.data() as RoutinePerformance)
              .toList(),
        );
  }
}
