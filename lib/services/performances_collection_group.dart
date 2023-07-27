import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/collection_group.dart';

class PerformancesCollectionGroup extends CollectionGroup<Performance> {
  static PerformancesCollectionGroup instance = PerformancesCollectionGroup();

  PerformancesCollectionGroup() : super(path: 'performances');

  @override
  Performance fromFirestore(snapshot, options) {
    return Performance.fromFirestore(snapshot, options);
  }

  Stream<List<ExercisePerformance>> forExercise(
    Exercise exercise, {
    required User user,
    Timestamp? before,
    int? limit,
  }) {
    var query = collectionGroup
        .where('user', isEqualTo: user.reference)
        .where('exercise.reference', isEqualTo: exercise.reference)
        .where('timestamp', isLessThan: before)
        .orderBy('timestamp', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => doc.data() as ExercisePerformance).toList());
  }

  Stream<List<RoutinePerformance>> forRoutine(
    Routine routine, {
    required User user,
    Timestamp? before,
    int? limit,
  }) {
    var query = collectionGroup
        .where('user', isEqualTo: user.reference)
        .where('routine.reference', isEqualTo: routine.reference)
        .where('timestamp', isLessThan: before)
        .orderBy('timestamp', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => doc.data() as RoutinePerformance).toList());
  }
}
