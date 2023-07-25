import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/services/collection_group.dart';

class ExercisesCollectionGroup extends CollectionGroup<Exercise> {
  static ExercisesCollectionGroup instance = ExercisesCollectionGroup();

  ExercisesCollectionGroup() : super(path: 'exercises');

  @override
  Exercise fromFirestore(snapshot, options) {
    return Exercise.fromFirestore(snapshot, options);
  }

  @override
  Stream<List<Exercise>> all() {
    return collectionGroup
        .orderBy('name')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
