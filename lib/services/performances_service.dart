import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/performances.dart';
import 'package:vim/models/exercise/resistance_exercise_performance.dart';
import 'package:vim/models/exercise/weights_exercise_performance.dart';

/// TODO: Filter all operations by the currently authenticated user. It might be
/// a good idea to apply this generally to the entire service:
/// ```
///   instance
///     .collection('users')
///     .document(user.uid)
///     .collection('performances')
///     ...
/// ```
class PerformancesService {
  static final CollectionReference<Performance> _collection = FirebaseFirestore
      .instance
      .collection('performances')
      .withConverter<Performance>(
        fromFirestore: (snapshot, _) {
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
          } else {
            return Performance.fromSnapshot(snapshot);
          }
        },
        toFirestore: (performance, _) => performance.toMap(),
      );

  static Stream<Performances> forDate(DateTime date) {
    DateTime today = DateTime(date.year, date.month, date.day);
    DateTime tomorrow = today.add(const Duration(days: 1));

    return _collection
        .where(
          'timestamp',
          isGreaterThanOrEqualTo: Timestamp.fromDate(today),
          isLessThan: Timestamp.fromDate(tomorrow),
        )
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) =>
            Performances(snapshot.docs.map((doc) => doc.data()).toList()));
  }

  static Future<void> create(Performance performance) async {
    assert(performance.reference == null);
    return _collection.doc().set(performance);
  }

  static Future<void> update(Performance performance) async {
    assert(performance.reference != null);
    return performance.reference!.set(performance);
  }

  static Future<void> delete(Performance performance) async {
    assert(performance.reference != null);
    return performance.reference!.delete();
  }
}
