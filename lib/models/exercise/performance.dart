import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/services/service.dart';

/// TODO: Make this an abstract class and create a ManualPerformance subclass,
/// so that the ManualPerformance can have a calories setter without the other
/// subclasses of Performance inheriting that setter.
class Performance extends Document {
  DocumentReference? _reference;

  Timestamp timestamp;
  String name;
  num _calories;

  Future<num> get calories {
    return Future(() => _calories);
  }

  @override
  DocumentReference? get reference => _reference;

  Performance({
    required this.timestamp,
    required this.name,
    required num calories,
  }) : _calories = calories;

  @override
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'name': name,
      'calories': calories,
    };
  }

  /// TODO: Related to the comment above this class, when there is a
  /// ManualPerformance subclass, this method should be removed.
  void setCalories(num calories) {
    _calories = calories;
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
