import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/document.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/quick_performance.dart';
import 'package:vim/models/exercise/routine_performance.dart';

abstract class Performance extends Document {
  DocumentReference user;
  Timestamp timestamp;

  String get name;
  FutureOr<num> get calories;

  Performance({
    required this.user,
    required this.timestamp,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'timestamp': timestamp,
    };
  }

  factory Performance.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return Performance.fromMap(snapshot.data()!)
      ..reference = snapshot.reference.withConverter<Performance>(
        fromFirestore: Performance.fromFirestore,
        toFirestore: (exercise, _) => exercise.toMap(),
      );
  }

  factory Performance.fromMap(Map<String, dynamic> map) {
    if (map['exercise'] != null) {
      return ExercisePerformance.fromMap(map);
    } else if (map['routine'] != null) {
      return RoutinePerformance.fromMap(map);
    } else {
      return QuickPerformance.fromMap(map);
    }
  }
}
