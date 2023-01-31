import 'package:vim/models/model.dart';

abstract class NutrientGroup<T extends NutrientGroup<T>> extends Model {
  T add(T addition);
  T multiply(double factor);

  const NutrientGroup();

  double? _addNutrient(double? a, double? b) {
    return a != null || b != null ? (a ?? 0) + (b ?? 0) : null;
  }

  double? _multiplyNutrient(double? value, double factor) {
    return value != null ? (value * factor) : null;
  }

  bool isComplete();
}

class Nutrition extends NutrientGroup<Nutrition> {
  final double calories;
  final Carbohydrates carbohydrates;
  final Proteins proteins;
  final Fats fats;
  final Minerals minerals;

  const Nutrition({
    this.calories = 0,
    this.carbohydrates = const Carbohydrates(null),
    this.proteins = const Proteins(null),
    this.fats = const Fats(null),
    this.minerals = const Minerals(),
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'calories': calories,
      'carbohydrates': carbohydrates.toMap(),
      'proteins': proteins.toMap(),
      'fats': fats.toMap(),
      'minerals': minerals.toMap(),
    };
  }

  static Nutrition fromMap(Map<String, dynamic> map) {
    return Nutrition(
      calories: map['calories'],
      carbohydrates: Carbohydrates.fromMap(map['carbohydrates']),
      proteins: Proteins.fromMap(map['proteins']),
      fats: Fats.fromMap(map['fats']),
      minerals: Minerals.fromMap(map['minerals']),
    );
  }

  @override
  Nutrition add(Nutrition addition) {
    return Nutrition(
      calories: calories + addition.calories,
      carbohydrates: carbohydrates.add(addition.carbohydrates),
      proteins: proteins.add(addition.proteins),
      fats: fats.add(addition.fats),
      minerals: minerals.add(addition.minerals),
    );
  }

  @override
  Nutrition multiply(double factor) {
    return Nutrition(
      calories: calories * factor,
      carbohydrates: carbohydrates.multiply(factor),
      proteins: proteins.multiply(factor),
      fats: fats.multiply(factor),
      minerals: minerals.multiply(factor),
    );
  }

  @override
  bool isComplete() {
    return fats.isComplete() &&
        carbohydrates.isComplete() &&
        proteins.isComplete() &&
        minerals.isComplete();
  }
}

class Carbohydrates extends NutrientGroup<Carbohydrates> {
  final double? total;
  final double? sugars;
  final double? fibers;

  const Carbohydrates(
    this.total, {
    this.sugars,
    this.fibers,
  }) : assert((sugars ?? 0) <= (total ?? 0));

  static calories(double grams) {
    return grams * 4;
  }

  static grams(double calories) {
    return calories / 4;
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

  @override
  Carbohydrates add(Carbohydrates addition) {
    return Carbohydrates(
      _addNutrient(total, addition.total),
      sugars: _addNutrient(sugars, addition.sugars),
      fibers: _addNutrient(fibers, addition.fibers),
    );
  }

  @override
  Carbohydrates multiply(double factor) {
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
  final double? total;
  final double? saturates;

  const Fats(
    this.total, {
    this.saturates,
  }) : assert((saturates ?? 0) <= (total ?? 0));

  static calories(double grams) {
    return grams * 9;
  }

  static grams(double calories) {
    return calories / 9;
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

  @override
  Fats add(Fats addition) {
    return Fats(
      _addNutrient(total, addition.total),
      saturates: _addNutrient(saturates, addition.saturates),
    );
  }

  @override
  Fats multiply(double factor) {
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
  final double? total;

  const Proteins(this.total);

  static calories(double grams) {
    return grams * 4;
  }

  static grams(double calories) {
    return calories / 4;
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

  @override
  Proteins add(Proteins addition) {
    return Proteins(
      _addNutrient(total, addition.total),
    );
  }

  @override
  Proteins multiply(double factor) {
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
  final double? salt;

  double? sodium() => Minerals.saltToSodium(salt);

  const Minerals({
    this.salt,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'salt': salt,
    };
  }

  static Minerals fromMap(Map<String, dynamic> map) {
    return Minerals(
      salt: map['salt'],
    );
  }

  static saltToSodium(double? grams) => grams != null ? grams * 0.4 : null;
  static sodiumToSalt(double? grams) => grams != null ? grams * 2.5 : null;

  @override
  Minerals add(Minerals addition) {
    return Minerals(
      salt: _addNutrient(salt, addition.salt),
    );
  }

  @override
  Minerals multiply(double factor) {
    return Minerals(
      salt: _multiplyNutrient(salt, factor),
    );
  }

  @override
  bool isComplete() {
    return salt != null;
  }
}
