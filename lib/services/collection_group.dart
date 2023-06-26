import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/document.dart';

abstract class CollectionGroup<D extends Document> {
  final String path;

  CollectionGroup({
    required this.path,
  });

  D fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  );

  Map<String, Object?> toFirestore(
    D instance,
    SetOptions? options,
  ) {
    return instance.toMap();
  }

  Query<D> get collectionGroup {
    return FirebaseFirestore.instance.collectionGroup(path).withConverter<D>(
          fromFirestore: fromFirestore,
          toFirestore: toFirestore,
        );
  }

  Stream<D?> get(String id) {
    return collectionGroup
        .where(FieldPath.documentId, isEqualTo: id)
        .limit(1)
        .snapshots()
        .map((snapshot) => snapshot.docs.firstOrNull?.data());
  }
}
