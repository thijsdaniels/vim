import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/performances.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/models/model.dart';

class Routine extends Model {
  String? _id;

  String name;
  Performances performances;

  String? get id => _id;

  num get calories => performances.calories;

  Routine({
    required this.name,
    required this.performances,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'performances': performances.toMap(),
    };
  }

  static Routine fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    Routine routine = fromMap(map);
    routine._id = snapshot.id;

    return routine;
  }

  static Routine fromMap(Map<String, dynamic> map) {
    return Routine(
      name: map['name'],
      performances: Performances.fromMap(map['performances']),
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
