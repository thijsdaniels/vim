import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
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

  Stream<D?> get(String path) {
    return collectionGroup
        .where(FieldPath.documentId, isEqualTo: path)
        .limit(1)
        .snapshots()
        .map((snapshot) => snapshot.docs.firstOrNull?.data());
  }

  /// TODO: Support more than 10 IDs.
  /// TODO: The `"nonExistantId"` is because Firestore doesn't allow `whereIn`
  /// on an empty array...
  // Stream<List<D>> some(List<String> ids) {
  //   return collectionGroup
  //       .where(
  //         FieldPath.documentId,
  //         whereIn: ids.isNotEmpty
  //             ? ids.slice(0, min(ids.length, 10))
  //             : ["nonExistantId"],
  //       )
  //       .snapshots()
  //       .map(
  //         (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
  //       );
  // }
}
