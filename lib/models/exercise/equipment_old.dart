import 'package:vim/models/document.dart';
import 'package:vim/models/mass.dart';

enum EquipmentType {
  bodyweight,
  isolationMachine,
  cableMachine,
  dumbbell,
  dumbbells,
  barbell,
  landmine,
  ezBar,
  trapBar,
  kettlebell,
  dippingBelt,
  weightVest,
}

abstract class Equipment extends Document {
  final String name;
  EquipmentType get type;

  Equipment({
    required this.name,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type.name,
      'name': name,
    };
  }
}

class Bodyweight extends Equipment {
  final double loadFactor;

  @override
  EquipmentType get type => EquipmentType.bodyweight;

  Bodyweight({
    this.loadFactor = 1,
  }) : super(name: "Bodyweight");

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'loadFactor': loadFactor,
    };
  }
}

abstract class Machine extends Equipment {
  final Mass weightIncrement;

  @override
  EquipmentType get type => EquipmentType.isolationMachine;

  Machine({
    required super.name,
    this.weightIncrement = const Mass.kilograms(0.5),
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'weightIncrement': weightIncrement.toMap(),
    };
  }
}

class IsolationMachine extends Machine {
  @override
  EquipmentType get type => EquipmentType.isolationMachine;

  IsolationMachine({
    super.name = "Isolation Machine",
    super.weightIncrement,
  });
}

class CableMachine extends Machine {
  @override
  EquipmentType get type => EquipmentType.cableMachine;

  CableMachine({
    super.name = "Isolation Machine",
    super.weightIncrement,
  });
}

abstract class FreeWeight extends Equipment {
  final Mass baseWeight;
  final double loadFactor;
  final Mass weightIncrement;

  FreeWeight({
    required super.name,
    required this.baseWeight,
    this.loadFactor = 1,
    this.weightIncrement = const Mass.kilograms(0.5),
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'baseWeight': baseWeight.toMap(),
      'loadFactor': loadFactor,
      'weightIncrement': weightIncrement.toMap(),
    };
  }
}

class Kettlebell extends FreeWeight {
  @override
  EquipmentType get type => EquipmentType.kettlebell;

  Kettlebell({
    super.name = "Kettlebell",
    super.baseWeight = const Mass.kilograms(1),
    super.loadFactor,
    super.weightIncrement = const Mass.kilograms(1),
  });
}

class DippingBelt extends FreeWeight {
  @override
  EquipmentType get type => EquipmentType.dippingBelt;

  DippingBelt({
    super.name = "Dipping Belt",
    super.baseWeight = const Mass.kilograms(1),
    super.loadFactor,
    super.weightIncrement,
  });
}

class WeightVest extends FreeWeight {
  @override
  EquipmentType get type => EquipmentType.weightVest;

  WeightVest({
    super.name = "Weight Vest",
    super.baseWeight = const Mass.kilograms(1),
    super.loadFactor,
    super.weightIncrement = const Mass.kilograms(1),
  });
}

abstract class Bar extends FreeWeight {
  Bar({
    required super.name,
    required super.baseWeight,
    super.loadFactor,

    /// Plates go as low as 0.5kg, but since you need to load both sides of the
    /// bar, the smallest increment is 1kg.
    super.weightIncrement = const Mass.kilograms(1),
  });
}

class Dumbbell extends Bar {
  @override
  EquipmentType get type => EquipmentType.dumbbell;

  Dumbbell({
    super.name = "Dumbell",
    super.loadFactor,

    /// The dumbbells I own have bars that weight 2kg.
    super.baseWeight = const Mass.kilograms(2),
    super.weightIncrement,
  });
}

class Dumbbells extends Dumbbell {
  @override
  EquipmentType get type => EquipmentType.dumbbells;

  Dumbbells({
    super.name = "Dumbbells",
    super.loadFactor = 2,
    super.baseWeight,
    super.weightIncrement,
  });
}

class Barbell extends Bar {
  @override
  EquipmentType get type => EquipmentType.barbell;

  Barbell({
    super.name = "Barbell",
    super.loadFactor,

    /// A standard olympic barbell weights 20kg.
    super.baseWeight = const Mass.kilograms(20),
    super.weightIncrement,
  });
}

class Landmine extends Barbell {
  @override
  EquipmentType get type => EquipmentType.landmine;

  Landmine({
    super.name = "Landmine",

    /// Since the barbell is on a pivot, half the load is carried by the ground.
    super.loadFactor = 0.5,
    super.baseWeight,

    /// Since you only load one side of the barbell, and plates go as low as
    /// 0.5kg, the smallest increment is 0.5kg.
    super.weightIncrement = const Mass.kilograms(0.5),
  });
}

class EZBar extends Bar {
  @override
  EquipmentType get type => EquipmentType.ezBar;

  EZBar({
    super.name = "EZ Bar",
    super.loadFactor,

    /// A standard EZ bar weights 10kg.
    super.baseWeight = const Mass.kilograms(10),
    super.weightIncrement,
  });
}

class TrapBar extends Bar {
  @override
  EquipmentType get type => EquipmentType.trapBar;

  TrapBar({
    super.name = "Trap Bar",
    super.baseWeight = const Mass.kilograms(30),
    super.loadFactor,
    super.weightIncrement,
  });
}
