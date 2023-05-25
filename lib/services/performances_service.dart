import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/resistance_exercise_performance.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/models/exercise/weights_exercise_performance.dart';
import 'package:vim/services/service.dart';

/// TODO: Filter all operations by the currently authenticated user. It might be
/// a good idea to apply this generally to the entire service:
/// ```
///   instance
///     .collection('users')
///     .document(user.uid)
///     .collection('performances')
///     ...
/// ```
class PerformancesService extends Service<Performance> {
  static final instance = PerformancesService();

  @override
  final CollectionReference<Performance> collection = FirebaseFirestore.instance
      .collection('performances')
      .withConverter<Performance>(
        fromFirestore: _fromFirestore,
        toFirestore: _toFirestore,
      );

  static Performance _fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? _) {
    Map<String, dynamic> data = snapshot.data()!;

    if (data['exercise'] != null) {
      switch (ExerciseType.values.byName(data['exercise']['type'])) {
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

  static Map<String, dynamic> _toFirestore(performance, _) =>
      performance.toMap();

  Stream<List<Performance>> forDate(DateTime date) {
    DateTime today = DateTime(date.year, date.month, date.day);
    DateTime tomorrow = today.add(const Duration(days: 1));

    return collection
        .where(
          'timestamp',
          isGreaterThanOrEqualTo: Timestamp.fromDate(today),
          isLessThan: Timestamp.fromDate(tomorrow),
        )
        .orderBy('timestamp')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }

  /// TODO: This is a strange exception to the pattern, since it does not query
  /// just the root `performances` collection, but the entire collection _group_
  /// of `performances. Technically, this is a _different_ collection, and I
  /// think I should create a separate class for that. Another quirk is that it
  /// returns a stream of `ExercisePerformance` rather than the `Performance`
  /// that this class extends `Service` with.
  Stream<ExercisePerformance> latest({
    required String name,
    Timestamp? before,
  }) {
    return FirebaseFirestore.instance
        .collectionGroup('performances')
        .withConverter<Performance>(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .where('exercise.name', isEqualTo: name)
        .where('timestamp', isLessThan: before)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) => snapshot.docs[0].data() as ExercisePerformance);
  }
}
