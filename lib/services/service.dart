import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:vim/models/document.dart';

/// TODO: Rename to Collection to reflect that this represents a Firestore
/// collection. If I have other non-Firestore services, I should make a Service
/// super class or interface for that, but this class is tightly coupled to
/// Firestore.
abstract class Service<D extends Document> {
  final String path;

  Service({
    required this.path,
  });

  D fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  );

  Map<String, Object?> toFirestore(
    D instance,
    SetOptions? options,
  ) =>
      instance.toMap();

  CollectionReference<D> get collection {
    return FirebaseFirestore.instance.collection(path).withConverter<D>(
          fromFirestore: fromFirestore,
          toFirestore: toFirestore,
        );
  }

  Stream<List<D>> all() {
    return collection.orderBy('name').snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }

  Stream<D?> get(String id) {
    return collection.doc(id).snapshots().map((snapshot) => snapshot.data());
  }

  /// TODO: Support more than 10 IDs.
  /// TODO: The `"nonExistantId"` is because Firestore doesn't allow `whereIn`
  /// on an empty array...
  Stream<List<D>> some(List<String> ids) {
    return collection
        .where(
          FieldPath.documentId,
          whereIn: ids.isNotEmpty
              ? ids.slice(0, min(ids.length, 10))
              : ["nonExistantId"],
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }

  Future<void> create(D document) async {
    assert(document.reference == null);
    return collection.doc().set(document);
  }

  Future<void> update(D document) async {
    assert(document.reference != null);

    /// TODO: Test if the `withConverter` is required, or if the reference
    /// contains references to those already. If so, the `update` method could
    /// be moved to the `Document` class.
    document.reference!
        .withConverter(
          fromFirestore: fromFirestore,
          toFirestore: toFirestore,
        )
        .set(document);
  }

  /// TODO: This could be moved to the `Document` class, since it doesn't matter
  /// whhich collection the document is stored in.
  Future<void> delete(D document) async {
    assert(document.reference != null);
    return document.reference!.delete();
  }
}
