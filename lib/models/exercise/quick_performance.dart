import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/performance.dart';

class QuickPerformance extends Performance {
  DocumentReference? _reference;

  @override
  String name;

  @override
  FutureOr<num> calories;

  @override
  DocumentReference? get reference => _reference;

  QuickPerformance({
    required super.timestamp,
    required this.name,
    required this.calories,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'name': name,
      'calories': calories,
    };
  }

  static QuickPerformance fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    QuickPerformance performance = fromMap(map);
    performance._reference = snapshot.reference;

    return performance;
  }

  static QuickPerformance fromMap(Map<String, dynamic> map) {
    return QuickPerformance(
      timestamp: map['timestamp'],
      name: map['name'],
      calories: map['calories'],
    );
  }
}
