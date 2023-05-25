import 'package:cloud_firestore/cloud_firestore.dart';
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

  /// TODO: Is it okay to return a list of streams? Shouldn't I at least merge
  /// the individual streams returned by `get()` into a single stream? Or better
  /// yet, perform a single query with a where clause?
  List<Stream<D?>> some(List<String> ids) {
    return ids.map(get).toList();
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
