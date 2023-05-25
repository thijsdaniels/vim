import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/model.dart';

abstract class Document extends Model {
  DocumentReference? get reference;
}
