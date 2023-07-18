import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/document.dart';
import 'package:vim/models/mass.dart';

/// TODO: Add an option to use the user's bodyweight isntead of the base weight
/// and weight increment.
class Equipment extends Document {
  String name;
  Mass baseWeight;
  Mass weightIncrement;
  double loadFactor;

  Equipment({
    required this.name,
    this.baseWeight = const Mass.kilograms(0),
    this.loadFactor = 1,
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
      baseWeight: Mass.fromMap(map['baseWeight']),
      weightIncrement: Mass.fromMap(map['weightIncrement']),
      loadFactor: map['loadFactor'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'baseWeight': baseWeight.toMap(),
      'weightIncrement': weightIncrement.toMap(),
      'loadFactor': loadFactor,
    };
  }
}

var isolationMachine = Equipment(
  name: "Isolation Machine",
  weightIncrement: const Mass.kilograms(0.5),
);

var cableMachine = Equipment(
  name: "Cable Machine",
  weightIncrement: const Mass.kilograms(0.5),
);

var kettleBell = Equipment(
  name: "Kettlebell",
  baseWeight: const Mass.kilograms(1),
  weightIncrement: const Mass.kilograms(1),
);

var dippingBelt = Equipment(
  name: "Dipping Belt",
  baseWeight: const Mass.kilograms(1),
  weightIncrement: const Mass.kilograms(1),
);

var weightVest = Equipment(
  name: "Weight Vest",
  baseWeight: const Mass.kilograms(1),
  weightIncrement: const Mass.kilograms(1),
);

var dumbbell = Equipment(
  name: "Dumbbell",
  baseWeight: const Mass.kilograms(2),
  weightIncrement: const Mass.kilograms(1),
);

var dumbbells = Equipment(
  name: "Dumbbells",
  baseWeight: const Mass.kilograms(2),
  weightIncrement: const Mass.kilograms(1),
  loadFactor: 2,
);

var barbell = Equipment(
  name: "Barbell",
  baseWeight: const Mass.kilograms(20),
  weightIncrement: const Mass.kilograms(1),
);

var landmine = Equipment(
  name: "Landmine",
  baseWeight: const Mass.kilograms(20),
  weightIncrement: const Mass.kilograms(0.5),
  loadFactor: 0.5,
);

var ezBar = Equipment(
  name: "EZ Bar",
  baseWeight: const Mass.kilograms(10),
  weightIncrement: const Mass.kilograms(1),
);

var trapBar = Equipment(
  name: "Trap Bar",
  baseWeight: const Mass.kilograms(30),
  weightIncrement: const Mass.kilograms(1),
);
