import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/equipment.dart';
import 'package:vim/services/collection_group.dart';

class EquipmentsCollectionGroup extends CollectionGroup<Equipment> {
  static EquipmentsCollectionGroup instance = EquipmentsCollectionGroup();

  EquipmentsCollectionGroup() : super(path: 'equipments');

  @override
  Equipment fromFirestore(snapshot, options) {
    return Equipment.fromFirestore(snapshot, options);
  }

  @override
  Stream<List<Equipment>> all({
    List<DocumentReference>? users,
  }) {
    return collectionGroup
        .where('user', whereIn: users)
        .orderBy('name')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
