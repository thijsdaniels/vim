import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/document.dart';
import 'package:vim/models/exercise/routine_performance.dart';

class Routine extends Document {
  DocumentReference? _reference;

  String name;
  List<DocumentReference> exerciseReferences;

  @override
  DocumentReference? get reference => _reference;

  Routine({
    required this.name,
    required this.exerciseReferences,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'exercises': exerciseReferences,
    };
  }

  static Routine fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    Routine routine = fromMap(map);
    routine._reference = snapshot.reference;

    return routine;
  }

  static Routine fromMap(Map<String, dynamic> map) {
    return Routine(
      name: map['name'],
      exerciseReferences:
          List.castFrom<dynamic, DocumentReference>(map['exercises']),
    );
  }

  RoutinePerformance performance({
    required Timestamp timestamp,
  }) {
    return RoutinePerformance(
      timestamp: timestamp,
      routine: this,
    );
  }
}
