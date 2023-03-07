import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/models/model.dart';

class Performance extends Model {
  DocumentReference? _reference;

  Timestamp? timestamp;
  String name;
  num calories;

  DocumentReference? get reference => _reference;

  Performance({
    required this.timestamp,
    required this.name,
    required this.calories,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'name': name,
      'calories': calories,
    };
  }

  static Performance fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    Performance performance = fromMap(map);
    performance._reference = snapshot.reference;

    return performance;
  }

  static Performance fromMap(Map<String, dynamic> map) {
    return Performance(
      timestamp: map['timestamp'],
      name: map['name'],
      calories: map['calories'],
    );
  }
}
