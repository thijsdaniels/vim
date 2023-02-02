import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/model.dart';

class Exercise extends Model {
  DocumentReference? _reference;

  String name;
  num calories;

  DocumentReference? get reference => _reference;

  Exercise({
    required this.name,
    required this.calories,
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
      name: map['name'],
      calories: map['calories'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'calories': calories,
    };
  }
}
