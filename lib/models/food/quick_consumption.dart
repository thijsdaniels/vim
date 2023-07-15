import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/nutrition.dart';

class QuickConsumption extends Consumption {
  DocumentReference? _reference;

  @override
  String name;
  @override
  Nutrition nutrition;

  @override
  DocumentReference? get reference => _reference;

  QuickConsumption({
    required super.timestamp,
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

  static QuickConsumption fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    QuickConsumption consumption = fromMap(map);
    consumption._reference = snapshot.reference;

    return consumption;
  }

  static QuickConsumption fromMap(Map<String, dynamic> map) {
    return QuickConsumption(
      timestamp: map['timestamp'],
      name: map['name'],
      nutrition: Nutrition.fromMap(map['nutrition']),
    );
  }
}
