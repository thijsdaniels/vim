import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/services/collection_group.dart';

class ExercisesCollectionGroup extends CollectionGroup<Exercise> {
  static ExercisesCollectionGroup instance = ExercisesCollectionGroup();

  ExercisesCollectionGroup() : super(path: 'exercises');

  @override
  Exercise fromFirestore(snapshot, options) {
    return Exercise.fromFirestore(snapshot, options);
  }
}
