import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/document.dart';
import 'package:vim/models/mass.dart';

/// TODO: Add an option to use the user's bodyweight isntead of the base weight
/// and weight increment.
class Equipment extends Document {
  String name;
  // Mass baseWeight;
  Mass weightIncrement;
  // num loadFactor;

  Equipment({
    required this.name,
    // this.baseWeight = const Mass.kilograms(0),
    // this.loadFactor = 1,
    this.weightIncrement = const Mass.kilograms(0),
  });

  factory Equipment.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return Equipment.fromMap(snapshot.data()!)
      ..reference = snapshot.reference.withConverter<Equipment>(
        fromFirestore: Equipment.fromFirestore,
        toFirestore: (equipment, _) => equipment.toMap(),
      );
  }

  factory Equipment.fromMap(Map<String, dynamic> map) {
    return Equipment(
      name: map['name'],
      // baseWeight: Mass.fromMap(map['baseWeight']),
      weightIncrement: Mass.fromMap(map['weightIncrement']),
      // loadFactor: map['loadFactor'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      // 'baseWeight': baseWeight.toMap(),
      'weightIncrement': weightIncrement.toMap(),
      // 'loadFactor': loadFactor,
    };
  }
}
