import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/document.dart';

enum ExerciseType {
  manual,
  resistance,
  weights,
}

class Exercise extends Document {
  DocumentReference? _reference;
  ExerciseType type;
  String name;

  @override
  DocumentReference? get reference => _reference;

  Exercise({
    required this.type,
    required this.name,
  });

  static Exercise fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    Exercise exercise = fromMap(map);
    exercise._reference = snapshot.reference;

    return exercise;
  }

  static Exercise fromMap(Map<String, dynamic> map) {
    return Exercise(
      type: ExerciseType.values.byName(map['type']),
      name: map['name'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type.name,
      'name': name,
    };
  }
}
