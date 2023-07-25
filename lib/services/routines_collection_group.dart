import 'package:vim/models/exercise/routine.dart';
import 'package:vim/services/collection_group.dart';

class RoutinesCollectionGroup extends CollectionGroup<Routine> {
  static RoutinesCollectionGroup instance = RoutinesCollectionGroup();

  RoutinesCollectionGroup() : super(path: 'routines');

  @override
  Routine fromFirestore(snapshot, options) {
    return Routine.fromFirestore(snapshot, options);
  }

  @override
  Stream<List<Routine>> all() {
    return collectionGroup
        .orderBy('name')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
