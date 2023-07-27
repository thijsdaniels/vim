import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/document.dart';

/// TODO: Rename to Collection to reflect that this represents a Firestore
/// collection. If I have other non-Firestore services, I should make a Service
/// super class or interface for that, but this class is tightly coupled to
/// Firestore.
abstract class Collection<D extends Document> {
  final String path;

  Collection({
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
    var snapshots = collection.snapshots();
    var documents = snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
    print(documents.toList());
    return documents;
  }

  Stream<D?> get(String id) {
    return collection.doc(id).snapshots().map((doc) => doc.data());
  }

  Future<DocumentReference<D>> create(
    D document, {
    String? id,
  }) async {
    assert(document.reference == null);

    DocumentReference<D> reference;

    if (id != null) {
      reference = collection.doc(id);
      reference.set(document);
    } else {
      reference = await collection.add(document);
    }

    document.reference = reference;

    await document.onCreate();

    return reference;
  }

  Future<void> update(D document) async {
    await document.update();
  }

  Future<void> delete(D document) async {
    await document.delete();
  }
}
