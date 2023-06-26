import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/services/service.dart';

/// TODO: Filter all operations by the currently authenticated user. It might be
/// a good idea to apply this generally to the entire service:
/// ```
///   instance
///     .collection('users')
///     .document(user.uid)
///     .collection('exercises')
///     ...
/// ```
class ExercisesService extends Service<Exercise> {
  static final instance = ExercisesService();

  ExercisesService() : super(path: 'exercises');

  @override
  Exercise fromFirestore(snapshot, options) {
    return Exercise.fromSnapshot(snapshot);
  }
}
