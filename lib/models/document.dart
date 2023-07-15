import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/model.dart';

abstract class Document extends Model {
  DocumentReference? _reference;

  DocumentReference? get reference => _reference;

  Future<void> onCreate(DocumentReference reference) async {
    _reference = reference;
  }

  Future<void> onUpdate() async {}

  Future<void> onDelete() async {}
}
