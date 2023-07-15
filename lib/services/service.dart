import 'package:cloud_firestore/cloud_firestore.dart';
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

  /// TODO: This is a really handy method when I need to migrate data. It might
  /// also be useful for other cases, so maybe I should make it official.
  // Future<List<D>> getAll() async {
  //   return (await collection.get()).docs.map((doc) => doc.data()).toList();
  // }

  Stream<List<D>> all() {
    return collection.snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }

  Stream<D?> get(String id) {
    return collection.doc(id).snapshots().map((snapshot) => snapshot.data());
  }

  Future<DocumentReference<D>> create(D document) async {
    assert(document.reference == null);

    var reference = await collection.add(document);
    await document.onCreate(reference);

    return reference;
  }

  /// TODO: Make the Document classes use properly typed DocumentReferences so
  /// that updating them is just a matter of document.reference.set(document).
  /// That way, we could move this method to the Document class.
  Future<void> update(D document) async {
    assert(document.reference != null);

    await collection.doc(document.reference!.id).set(document);

    await document.onUpdate();
  }

  /// TODO: This could be moved to the `Document` class, since it doesn't matter
  /// which collection the document is stored in.
  Future<void> delete(D document) async {
    assert(document.reference != null);

    await document.reference!.delete();

    await document.onDelete();
  }
}
