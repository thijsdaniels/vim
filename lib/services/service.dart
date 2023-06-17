import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:vim/models/document.dart';

/// TODO: Rename to Collection to reflect that this represents a Firestore
/// collection. If I have other non-Firestore services, I should make a Service
/// super class or interface for that, but this class is tightly coupled to
/// Firestore.
abstract class Service<D extends Document> {
  CollectionReference<D> get collection;

  Stream<List<D>> all() {
    return collection.orderBy('name').snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }

  Stream<D?> get(String id) {
    return collection.doc(id).snapshots().map((snapshot) => snapshot.data());
  }

  Stream<List<D>> some(List<String> ids) {
    return collection
        .where(
          FieldPath.documentId,
          whereIn: ids.slice(0, 10), // TODO: Support more than 10 IDs.
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
    return collection.doc(document.reference!.id).set(document);
  }

  Future<void> delete(D document) async {
    assert(document.reference != null);
    return collection.doc(document.reference!.id).delete();
  }
}
