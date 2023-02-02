import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercises.dart';
import 'package:vim/models/exercise/resistance_exercise.dart';
import 'package:vim/models/exercise/weights_exercise.dart';

/// TODO: Filter all operations by the currently authenticated user. It might be
/// a good idea to apply this generally to the entire service:
/// ```
///   instance
///     .collection('users')
///     .document(user.uid)
///     .collection('exercises')
///     ...
/// ```
class ExercisesService {
  static final CollectionReference<Exercise> _collection = FirebaseFirestore
      .instance
      .collection('exercises')
      .withConverter<Exercise>(
        fromFirestore: (snapshot, _) {
          Map<String, dynamic> data = snapshot.data()!;

          if (data['sets'] != null) {
            return WeightsExercise.fromSnapshot(snapshot);
          } else if (data['duration'] != null) {
            return ResistanceExercise.fromSnapshot(snapshot);
          } else {
            return Exercise.fromSnapshot(snapshot);
          }
        },
        toFirestore: (exercise, _) => exercise.toMap(),
      );

  static Stream<Exercises> all() {
    return _collection.orderBy('name').snapshots().map((snapshot) =>
        Exercises(snapshot.docs.map((doc) => doc.data()).toList()));
  }

  static Future<void> create(Exercise exercise) async {
    assert(exercise.reference == null);
    return _collection.doc().set(exercise);
  }

  static Future<void> update(Exercise exercise) async {
    assert(exercise.reference != null);
    return _collection.doc(exercise.reference!.id).set(exercise);
  }

  static Future<void> delete(Exercise exercise) async {
    assert(exercise.reference != null);
    return _collection.doc(exercise.reference!.id).delete();
  }
}
