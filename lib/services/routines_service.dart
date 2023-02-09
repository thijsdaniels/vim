import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/models/exercise/routines.dart';

/// TODO: Filter all operations by the currently authenticated user. It might be
/// a good idea to apply this generally to the entire service:
/// ```
///   instance
///     .collection('users')
///     .document(user.uid)
///     .collection('routines')
///     ...
/// ```
class RoutinesService {
  static final CollectionReference<Routine> _collection =
      FirebaseFirestore.instance.collection('routines').withConverter<Routine>(
            fromFirestore: (snapshot, _) => Routine.fromSnapshot(snapshot),
            toFirestore: (routine, _) => routine.toMap(),
          );

  static Stream<Routines> all() {
    return _collection.orderBy('name').snapshots().map((snapshot) =>
        Routines(snapshot.docs.map((doc) => doc.data()).toList()));
  }

  static Future<void> create(Routine routine) async {
    assert(routine.id == null);
    return _collection.doc().set(routine);
  }

  static Future<void> update(Routine routine) async {
    assert(routine.id != null);
    return _collection.doc(routine.id).set(routine);
  }

  static Future<void> delete(Routine routine) async {
    assert(routine.id != null);
    return _collection.doc(routine.id).delete();
  }
}
