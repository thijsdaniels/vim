import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/performance.dart';

abstract class ExercisePerformance extends Performance {
  DocumentReference? _reference;

  ExerciseSnapshot exercise;

  @override
  DocumentReference? get reference => _reference;

  @override
  String get name => exercise.snapshot.name;

  ExercisePerformance({
    required super.timestamp,
    required this.exercise,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'exercise': exercise.toMap(),
    };
  }
}
