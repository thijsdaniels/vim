import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/document.dart';
import 'package:vim/models/food/nutrition.dart';

class Consumption extends Document {
  DocumentReference? _reference;
  Timestamp timestamp;
  String name;
  Nutrition nutrition;

  @override
  DocumentReference? get reference => _reference;

  Consumption({
    required this.timestamp,
    required this.name,
    required this.nutrition,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'name': name,
      'nutrition': nutrition.toMap(),
    };
  }

  static Consumption fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    Consumption consumption = fromMap(map);
    consumption._reference = snapshot.reference;

    return consumption;
  }

  static Consumption fromMap(Map<String, dynamic> map) {
    return Consumption(
      timestamp: map['timestamp'],
      name: map['name'],
      nutrition: Nutrition.fromMap(map['nutrition']),
    );
  }
}
