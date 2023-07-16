import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/document.dart';
import 'package:vim/models/model.dart';

class Snapshot<T extends Document> extends Model {
  final T snapshot;

  /// TODO: Make this a `DocumentReference<T>`.
  late final DocumentReference reference;

  Snapshot(
    this.snapshot, {
    DocumentReference? reference,
  }) : assert(reference != null || snapshot.reference != null) {
    this.reference = (reference ?? snapshot.reference)!;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'reference': reference,
      'snapshot': snapshot.toMap(),
    };
  }
}
