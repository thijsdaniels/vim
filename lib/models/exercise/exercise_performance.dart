import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/document.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/model.dart';

class ExercisePerformance extends Performance {
  DocumentReference? _reference;

  ExerciseSnapshot exercise;

  @override
  DocumentReference? get reference => _reference;

  @override
  String get name => exercise.snapshot.name;

  ExercisePerformance({
    required super.timestamp,
    required this.exercise,
    required super.calories,
  }) : super(
          name: exercise.snapshot.name,
        );

  static ExercisePerformance fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    ExercisePerformance exercisePerformance = fromMap(map);
    exercisePerformance._reference = snapshot.reference;

    return exercisePerformance;
  }

  static ExercisePerformance fromMap(Map<String, dynamic> map) {
    return ExercisePerformance(
      timestamp: map['timestamp'],
      exercise: ExerciseSnapshot.fromMap(map['exercise']),
      calories: map['calories'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'exercise': exercise.toMap(),
      'calories': calories,
    };
  }
}

class ExerciseSnapshot extends Snapshot<Exercise> {
  ExerciseSnapshot(
    super.snapshot, {
    super.reference,
  });

  static ExerciseSnapshot fromMap(Map<String, dynamic> map) {
    return ExerciseSnapshot(
      Exercise.fromMap(map['snapshot']),
      reference: map['reference'],
    );
  }
}

class Snapshot<T extends Document> extends Model {
  final T snapshot;
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
