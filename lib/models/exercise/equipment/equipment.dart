import 'package:vim/models/mass.dart';

class Equipment {
  final String name;

  const Equipment({
    required this.name,
  });
}

class Weight extends Equipment {
  final Mass weight;
  final double load;
  final Mass increment;

  const Weight({
    required super.name,
    required this.weight,
    this.load = 1,
    this.increment = const Mass.kilograms(0.5),
  });
}

class Barbell extends Weight {
  const Barbell({
    super.name = "Barbell",
    super.weight = const Mass.kilograms(20),
    super.load,
    // since you generally put weight on both sides of the barbell
    super.increment = const Mass.kilograms(1),
  });
}

class Landmine extends Barbell {
  const Landmine({
    super.name = "Landmine",
    super.weight,
    // only count half the bar, because it's on a pivot
    super.load = 0.5,
    // since you load a barbell in a landmine only on a single side
    super.increment = const Mass.kilograms(0.5),
  });
}
