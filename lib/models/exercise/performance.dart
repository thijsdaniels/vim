import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/document.dart';

abstract class Performance extends Document {
  DocumentReference? _reference;

  Timestamp timestamp;

  @override
  DocumentReference? get reference => _reference;

  String get name;
  FutureOr<num> get calories;

  Performance({
    required this.timestamp,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
    };
  }
}
