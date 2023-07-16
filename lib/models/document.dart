import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/model.dart';

abstract class Document extends Model {
  /// TODO: Make the reference final and non-nullable, by adding it as a
  /// required parameter of the constructor.
  /// TODO: Use generics to make sure that subclasses of `Document` have a
  /// `DocumentReference` of the subclass type.
  DocumentReference? reference;

  Document();

  Document.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  );

  Document.fromMap(Map<String, dynamic> map);

  Future<void> onCreate() async {}

  Future<void> update() async {
    assert(reference != null);
    await reference!.set(this);
    await onUpdate();
  }

  Future<void> onUpdate() async {}

  Future<void> delete() async {
    assert(reference != null);
    await reference!.delete();
    await onDelete();
  }

  Future<void> onDelete() async {}
}
