import 'package:cloud_firestore/cloud_firestore.dart';

/// @todo Figure out how to extend Document so that the `fromSnapshot` method is
/// inherited. Factory constructors and static methods aren't inherited in Dart,
/// and this is a problem because I don't want to repeat the logic of setting
/// the `_reference` in every document class.
abstract class Document {
  abstract final CollectionReference<Document> _collection;

  DocumentReference? _reference;

  // factory Document.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
  //   Map<String, dynamic> map = snapshot.data()!;
  //
  //   Document document = Document.fromMap(map);
  //   document._reference = snapshot.reference;
  //
  //   return document;
  // }

  // factory Document.fromMap(Map<String, dynamic> map);

  Future<void> save() async {
    if (_reference == null) {
      _reference = await _collection.add(this);
    } else {
      await _reference!.set(this);
    }
  }

  Future<void> delete() async {
    await _reference?.delete();
  }
}
