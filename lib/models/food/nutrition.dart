import 'package:vim/extensions/map.dart';
import 'package:vim/models/model.dart';

abstract class NutrientGroup<T extends NutrientGroup<T>> extends Model {
  T operator +(T other);
  T operator *(num factor);

  const NutrientGroup();

  num? _addNutrient(num? a, num? b) {
    return a != null || b != null ? (a ?? 0) + (b ?? 0) : null;
  }

  num? _multiplyNutrient(num? value, num factor) {
    return value != null ? (value * factor) : null;
  }

  bool isComplete();
}

class Nutrition extends NutrientGroup<Nutrition> {
  final num? calories;
  final Carbohydrates carbohydrates;
  final Proteins proteins;
  final Fats fats;
  final Minerals minerals;
  final Vitamins vitamins;
  final num? water;
  final num? alcohol;
  final Stimulants stimulants;

  const Nutrition({
    this.calories,
    this.carbohydrates = const Carbohydrates(null),
    this.proteins = const Proteins(null),
    this.fats = const Fats(null),
    this.minerals = const Minerals(),
    this.vitamins = const Vitamins(),
    this.water,
    this.alcohol,
    this.stimulants = const Stimulants(),
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'calories': calories,
      'carbohydrates': carbohydrates.toMap(),
      'proteins': proteins.toMap(),
      'fats': fats.toMap(),
      'minerals': minerals.toMap(),
      'vitamins': vitamins.toMap(),
      'water': water,
      'alcohol': alcohol,
      'stimulants': stimulants.toMap(),
    }.where((entry) => entry.value != null);
  }

  static Nutrition fromMap(Map<String, dynamic> map) {
    return Nutrition(
      calories: map['calories'],
      carbohydrates: Carbohydrates.fromMap(map['carbohydrates']),
      proteins: Proteins.fromMap(map['proteins']),
      fats: Fats.fromMap(map['fats']),
      minerals: Minerals.fromMap(map['minerals']),
      vitamins: map['vitamins'] != null
          ? Vitamins.fromMap(map['vitamins'])
          : const Vitamins(),
      water: map['water'],
      alcohol: map['alcohol'],
      stimulants: map['stimulants'] != null
          ? Stimulants.fromMap(map['stimulants'])
          : const Stimulants(),
    );
  }

  static const Nutrition empty = Nutrition(
    calories: null,
    carbohydrates: Carbohydrates.empty,
    proteins: Proteins.empty,
    fats: Fats.empty,
    minerals: Minerals.empty,
    vitamins: Vitamins.empty,
    water: null,
    alcohol: null,
    stimulants: Stimulants.empty,
  );

  @override
  Nutrition operator +(Nutrition other) {
    return Nutrition(
      calories: _addNutrient(calories, other.calories),
      carbohydrates: carbohydrates + other.carbohydrates,
      proteins: proteins + other.proteins,
      fats: fats + other.fats,
      minerals: minerals + other.minerals,
      vitamins: vitamins + other.vitamins,
      water: _addNutrient(water, other.water),
      alcohol: _addNutrient(alcohol, other.alcohol),
      stimulants: stimulants + other.stimulants,
    );
  }

  @override
  Nutrition operator *(num factor) {
    return Nutrition(
      calories: _multiplyNutrient(calories, factor),
      carbohydrates: carbohydrates * factor,
      proteins: proteins * factor,
      fats: fats * factor,
      minerals: minerals * factor,
      vitamins: vitamins * factor,
      water: _multiplyNutrient(water, factor),
      alcohol: _multiplyNutrient(alcohol, factor),
      stimulants: stimulants * factor,
    );
  }

  @override
  bool isComplete() {
    return fats.isComplete() &&
        carbohydrates.isComplete() &&
        proteins.isComplete() &&
        minerals.isComplete() &&
        vitamins.isComplete() &&
        water != null &&
        alcohol != null &&
        stimulants.isComplete();
  }
}

class Carbohydrates extends NutrientGroup<Carbohydrates> {
  static const caloriesPerGram = 4;

  final num? total;
  final num? sugars;
  final num? fibers;

  const Carbohydrates(
    this.total, {
    this.sugars,
    this.fibers,
  }) : assert((sugars ?? 0) <= (total ?? 0));

  static num calories(num grams) {
    return grams * caloriesPerGram;
  }

  static double grams(num calories) {
    return calories / caloriesPerGram;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'sugars': sugars,
      'fibers': fibers,
    };
  }

  static Carbohydrates fromMap(Map<String, dynamic> map) {
    return Carbohydrates(
      map['total'],
      sugars: map['sugars'],
      fibers: map['fibers'],
    );
  }

  static const Carbohydrates empty = Carbohydrates(
    null,
    sugars: null,
    fibers: null,
  );

  @override
  Carbohydrates operator +(Carbohydrates other) {
    return Carbohydrates(
      _addNutrient(total, other.total),
      sugars: _addNutrient(sugars, other.sugars),
      fibers: _addNutrient(fibers, other.fibers),
    );
  }

  @override
  Carbohydrates operator *(num factor) {
    return Carbohydrates(
      _multiplyNutrient(total, factor),
      sugars: _multiplyNutrient(sugars, factor),
      fibers: _multiplyNutrient(fibers, factor),
    );
  }

  @override
  bool isComplete() {
    return sugars != null && fibers != null;
  }
}

class Fats extends NutrientGroup<Fats> {
  static const caloriesPerGram = 9;

  final num? total;
  final num? saturates;

  const Fats(
    this.total, {
    this.saturates,
  }) : assert((saturates ?? 0) <= (total ?? 0));

  static num calories(num grams) {
    return grams * Fats.caloriesPerGram;
  }

  static double grams(num calories) {
    return calories / Fats.caloriesPerGram;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'saturates': saturates,
    };
  }

  static Fats fromMap(Map<String, dynamic>? map) {
    return Fats(
      map?['total'],
      saturates: map?['saturates'],
    );
  }

  static const Fats empty = Fats(
    null,
    saturates: null,
  );

  @override
  Fats operator +(Fats other) {
    return Fats(
      _addNutrient(total, other.total),
      saturates: _addNutrient(saturates, other.saturates),
    );
  }

  @override
  Fats operator *(num factor) {
    return Fats(
      _multiplyNutrient(total, factor),
      saturates: _multiplyNutrient(saturates, factor),
    );
  }

  @override
  bool isComplete() {
    return saturates != null;
  }
}

class Proteins extends NutrientGroup<Proteins> {
  static const caloriesPerGram = 4;

  final num? total;

  const Proteins(this.total);

  static num calories(num grams) {
    return grams * Proteins.caloriesPerGram;
  }

  static double grams(num calories) {
    return calories / Proteins.caloriesPerGram;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'total': total,
    };
  }

  static Proteins fromMap(Map<String, dynamic> map) {
    return Proteins(
      map['total'],
    );
  }

  static const Proteins empty = Proteins(null);

  @override
  Proteins operator +(Proteins other) {
    return Proteins(
      _addNutrient(total, other.total),
    );
  }

  @override
  Proteins operator *(num factor) {
    return Proteins(
      _multiplyNutrient(total, factor),
    );
  }

  @override
  bool isComplete() {
    return true;
  }
}

class Minerals extends NutrientGroup<Minerals> {
  final num? boron;
  final num? calcium;
  final num? chromium;
  final num? cobalt;
  final num? copper;
  final num? fluoride;
  final num? iodine;
  final num? iron;
  final num? magnesium;
  final num? manganese;
  final num? molybdenum;
  final num? nickel;
  final num? phosphorus;
  final num? potassium;
  final num? selenium;
  final num? silicon;
  final num? sodium;
  final num? vanadium;
  final num? zinc;

  num? salt() => Minerals.sodiumToSalt(sodium);

  const Minerals({
    this.boron,
    this.calcium,
    this.chromium,
    this.cobalt,
    this.copper,
    this.fluoride,
    this.iodine,
    this.iron,
    this.magnesium,
    this.manganese,
    this.molybdenum,
    this.nickel,
    this.phosphorus,
    this.potassium,
    this.selenium,
    this.silicon,
    this.sodium,
    this.vanadium,
    this.zinc,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'boron': boron,
      'calcium': calcium,
      'chromium': chromium,
      'cobalt': cobalt,
      'copper': copper,
      'fluoride': fluoride,
      'iodine': iodine,
      'iron': iron,
      'magnesium': magnesium,
      'manganese': manganese,
      'molybdenum': molybdenum,
      'nickel': nickel,
      'phosphorus': phosphorus,
      'potassium': potassium,
      'selenium': selenium,
      'silicon': silicon,
      'sodium': sodium,
      'vanadium': vanadium,
      'zinc': zinc,
    }.where((entry) => entry.value != null);
  }

  static Minerals fromMap(Map<String, dynamic> map) {
    return Minerals(
      boron: map['boron'],
      calcium: map['calcium'],
      chromium: map['chromium'],
      cobalt: map['cobalt'],
      copper: map['copper'],
      fluoride: map['fluoride'],
      iodine: map['iodine'],
      iron: map['iron'],
      magnesium: map['magnesium'],
      manganese: map['manganese'],
      molybdenum: map['molybdenum'],
      nickel: map['nickel'],
      phosphorus: map['phosphorus'],
      potassium: map['potassium'],
      selenium: map['selenium'],
      silicon: map['silicon'],
      sodium: map['sodium'] ?? saltToSodium(map['salt']),
      vanadium: map['vanadium'],
      zinc: map['zinc'],
    );
  }

  static const Minerals empty = Minerals(
    boron: null,
    calcium: null,
    chromium: null,
    cobalt: null,
    copper: null,
    fluoride: null,
    iodine: null,
    iron: null,
    magnesium: null,
    manganese: null,
    molybdenum: null,
    nickel: null,
    phosphorus: null,
    potassium: null,
    selenium: null,
    silicon: null,
    sodium: null,
    vanadium: null,
    zinc: null,
  );

  static num? saltToSodium(num? grams) => grams != null ? grams * 0.4 : null;
  static num? sodiumToSalt(num? grams) => grams != null ? grams * 2.5 : null;

  @override
  Minerals operator +(Minerals other) {
    return Minerals(
      boron: _addNutrient(boron, other.boron),
      calcium: _addNutrient(calcium, other.calcium),
      chromium: _addNutrient(chromium, other.chromium),
      cobalt: _addNutrient(cobalt, other.cobalt),
      copper: _addNutrient(copper, other.copper),
      fluoride: _addNutrient(fluoride, other.fluoride),
      iodine: _addNutrient(iodine, other.iodine),
      iron: _addNutrient(iron, other.iron),
      magnesium: _addNutrient(magnesium, other.magnesium),
      manganese: _addNutrient(manganese, other.manganese),
      molybdenum: _addNutrient(molybdenum, other.molybdenum),
      nickel: _addNutrient(nickel, other.nickel),
      phosphorus: _addNutrient(phosphorus, other.phosphorus),
      potassium: _addNutrient(potassium, other.potassium),
      selenium: _addNutrient(selenium, other.selenium),
      silicon: _addNutrient(silicon, other.silicon),
      sodium: _addNutrient(sodium, other.sodium),
      vanadium: _addNutrient(vanadium, other.vanadium),
      zinc: _addNutrient(zinc, other.zinc),
    );
  }

  @override
  Minerals operator *(num factor) {
    return Minerals(
      boron: _multiplyNutrient(boron, factor),
      calcium: _multiplyNutrient(calcium, factor),
      chromium: _multiplyNutrient(chromium, factor),
      cobalt: _multiplyNutrient(cobalt, factor),
      copper: _multiplyNutrient(copper, factor),
      fluoride: _multiplyNutrient(fluoride, factor),
      iodine: _multiplyNutrient(iodine, factor),
      iron: _multiplyNutrient(iron, factor),
      magnesium: _multiplyNutrient(magnesium, factor),
      manganese: _multiplyNutrient(manganese, factor),
      molybdenum: _multiplyNutrient(molybdenum, factor),
      nickel: _multiplyNutrient(nickel, factor),
      phosphorus: _multiplyNutrient(phosphorus, factor),
      potassium: _multiplyNutrient(potassium, factor),
      selenium: _multiplyNutrient(selenium, factor),
      silicon: _multiplyNutrient(silicon, factor),
      sodium: _multiplyNutrient(sodium, factor),
      vanadium: _multiplyNutrient(vanadium, factor),
      zinc: _multiplyNutrient(zinc, factor),
    );
  }

  @override
  bool isComplete() {
    return boron != null &&
        calcium != null &&
        chromium != null &&
        cobalt != null &&
        copper != null &&
        fluoride != null &&
        iodine != null &&
        iron != null &&
        magnesium != null &&
        manganese != null &&
        molybdenum != null &&
        nickel != null &&
        phosphorus != null &&
        potassium != null &&
        selenium != null &&
        silicon != null &&
        sodium != null &&
        vanadium != null &&
        zinc != null;
  }
}

class Vitamins extends NutrientGroup<Vitamins> {
  final num? a;
  final num? b1;
  final num? b2;
  final num? b3;
  final num? b5;
  final num? b6;
  final num? b7;
  final num? b9;
  final num? b12;
  final num? c;
  final num? d;
  final num? e;
  final num? k;

  const Vitamins({
    this.a,
    this.b1,
    this.b2,
    this.b3,
    this.b5,
    this.b6,
    this.b7,
    this.b9,
    this.b12,
    this.c,
    this.d,
    this.e,
    this.k,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'a': a,
      'b1': b1,
      'b2': b2,
      'b3': b3,
      'b5': b5,
      'b6': b6,
      'b7': b7,
      'b9': b9,
      'b12': b12,
      'c': c,
      'd': d,
      'e': e,
      'k': k,
    }.where((entry) => entry.value != null);
  }

  static Vitamins fromMap(Map<String, dynamic> map) {
    return Vitamins(
      a: map['a'],
      b1: map['b1'],
      b2: map['b2'],
      b3: map['b3'],
      b5: map['b5'],
      b6: map['b6'],
      b7: map['b7'],
      b9: map['b9'],
      b12: map['b12'],
      c: map['c'],
      d: map['d'],
      e: map['e'],
      k: map['k'],
    );
  }

  static const Vitamins empty = Vitamins(
    a: null,
    b1: null,
    b2: null,
    b3: null,
    b5: null,
    b6: null,
    b7: null,
    b9: null,
    b12: null,
    c: null,
    d: null,
    e: null,
    k: null,
  );

  @override
  Vitamins operator +(Vitamins other) {
    return Vitamins(
      a: _addNutrient(a, other.a),
      b1: _addNutrient(b1, other.b1),
      b2: _addNutrient(b2, other.b2),
      b3: _addNutrient(b3, other.b3),
      b5: _addNutrient(b5, other.b5),
      b6: _addNutrient(b6, other.b6),
      b7: _addNutrient(b7, other.b7),
      b9: _addNutrient(b9, other.b9),
      b12: _addNutrient(b12, other.b12),
      c: _addNutrient(c, other.c),
      d: _addNutrient(d, other.d),
      e: _addNutrient(e, other.e),
      k: _addNutrient(k, other.k),
    );
  }

  @override
  Vitamins operator *(num factor) {
    return Vitamins(
      a: _multiplyNutrient(a, factor),
      b1: _multiplyNutrient(b1, factor),
      b2: _multiplyNutrient(b2, factor),
      b3: _multiplyNutrient(b3, factor),
      b5: _multiplyNutrient(b5, factor),
      b6: _multiplyNutrient(b6, factor),
      b7: _multiplyNutrient(b7, factor),
      b9: _multiplyNutrient(b9, factor),
      b12: _multiplyNutrient(b12, factor),
      c: _multiplyNutrient(c, factor),
      d: _multiplyNutrient(d, factor),
      e: _multiplyNutrient(e, factor),
      k: _multiplyNutrient(k, factor),
    );
  }

  @override
  bool isComplete() {
    return a != null &&
        b1 != null &&
        b2 != null &&
        b3 != null &&
        b5 != null &&
        b6 != null &&
        b7 != null &&
        b9 != null &&
        b12 != null &&
        c != null &&
        d != null &&
        e != null &&
        k != null;
  }
}

class Stimulants extends NutrientGroup<Stimulants> {
  final num? caffeine;
  final num? creatine;

  const Stimulants({
    this.caffeine,
    this.creatine,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'caffeine': caffeine,
      'creatine': creatine,
    }.where((entry) => entry.value != null);
  }

  static Stimulants fromMap(Map<String, dynamic> map) {
    return Stimulants(
      caffeine: map['caffeine'],
      creatine: map['creatine'],
    );
  }

  static const Stimulants empty = Stimulants(
    caffeine: null,
    creatine: null,
  );

  @override
  Stimulants operator +(Stimulants other) {
    return Stimulants(
      caffeine: _addNutrient(caffeine, other.caffeine),
      creatine: _addNutrient(creatine, other.creatine),
    );
  }

  @override
  Stimulants operator *(num factor) {
    return Stimulants(
      caffeine: _multiplyNutrient(caffeine, factor),
      creatine: _multiplyNutrient(creatine, factor),
    );
  }

  @override
  bool isComplete() {
    return caffeine != null && creatine != null;
  }
}
