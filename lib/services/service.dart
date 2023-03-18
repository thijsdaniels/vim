import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/collection.dart';
import 'package:vim/models/model.dart';

abstract class Service<D extends Document> {
  CollectionReference<D> get collection;

  Stream<Collection<D>> all() {
    return collection.orderBy('name').snapshots().map(
          (snapshot) => Collection(
            snapshot.docs.map((doc) => doc.data()).toList(),
          ),
        );
  }

  Stream<D?> get(String id) {
    return collection.doc(id).snapshots().map((snapshot) => snapshot.data());
  }

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

abstract class Document extends Model {
  DocumentReference? get reference;
}
