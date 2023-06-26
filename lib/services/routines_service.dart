import 'package:vim/models/exercise/routine.dart';
import 'package:vim/services/service.dart';

/// TODO: Filter all operations by the currently authenticated user. It might be
/// a good idea to apply this generally to the entire service:
/// ```
///   instance
///     .collection('users')
///     .document(user.uid)
///     .collection('routines')
///     ...
/// ```
class RoutinesService extends Service<Routine> {
  static final instance = RoutinesService();

  RoutinesService() : super(path: 'routines');

  @override
  Routine fromFirestore(snapshot, options) {
    return Routine.fromSnapshot(snapshot);
  }
}
