import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/model.dart';

abstract class Document extends Model {
  /// TODO: Make the `reference` final and non-nullable, by adding it as a
  /// required parameter of the constructor.
  /// TODO: Use generics to make sure that subclasses of `Document` have a
  /// `DocumentReference` of the subclass type.
  DocumentReference? reference;

  Document({
    this.reference,
  });

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

mixin Owner on Document {
  DocumentReference? get user;
}

abstract class OwnedDocument extends Document with Owner {
  @override
  DocumentReference? user;

  OwnedDocument({
    super.reference,
    required this.user,
  });
}

mixin Name on Document {
  String? get name;
}

abstract class NamedDocument extends OwnedDocument with Name {
  @override
  String name;

  String get searchableText => name.toLowerCase();

  NamedDocument({
    super.reference,
    required super.user,
    required this.name,
  });
}
