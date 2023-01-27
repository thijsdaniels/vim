class Nutrition {
  final num calories;
  final Carbohydrates carbohydrates;
  final num protein;
  final Fat fat;

  /// @todo Should `fiber` be moved into the `Carbohydrates` class? Since the
  /// body doesn't absorb fibers, they should not count towards your intake of
  /// carbs, but they _are_ technically carbs...
  final num fiber;
  final num salt;

  const Nutrition({
    required this.calories,
    this.carbohydrates = const Carbohydrates(0),
    this.protein = 0,
    this.fat = const Fat(0),
    this.fiber = 0,
    this.salt = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'calories': calories,
      'carbohydrates': carbohydrates.toMap(),
      'protein': protein,
      'fat': fat.toMap(),
      'fiber': fiber,
      'salt': salt,
    };
  }

  static Nutrition fromMap(Map<String, dynamic> map) {
    return Nutrition(
      calories: map['calories'],
      carbohydrates: map['carbohydrates'] is num
          ? Carbohydrates(map['carbohydrates'])
          : Carbohydrates.fromMap(map['carbohydrates']),
      protein: map['protein'] ?? 0,
      fat: map['fat'] is num ? Fat(map['fat']) : Fat.fromMap(map['fat']),
      fiber: map['fiber'] ?? 0,
      salt: map['salt'] ?? 0,
    );
  }

  Nutrition add(Nutrition addition) {
    return Nutrition(
      calories: calories + addition.calories,
      carbohydrates: carbohydrates.add(addition.carbohydrates),
      protein: protein + addition.protein,
      fat: fat.add(addition.fat),
      fiber: fiber + addition.fiber,
      salt: salt + addition.salt,
    );
  }

  Nutrition multiply(double factor) {
    return Nutrition(
      calories: calories * factor,
      carbohydrates: carbohydrates.multiply(factor),
      protein: protein * factor,
      fat: fat.multiply(factor),
      fiber: fiber * factor,
      salt: salt * factor,
    );
  }
}

class Fat {
  final num total;
  final num saturates;

  const Fat(
    this.total, {
    this.saturates = 0,
  }) : assert(saturates <= total);

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'saturates': saturates,
    };
  }

  static Fat fromMap(Map<String, dynamic> map) {
    return Fat(
      map['total'],
      saturates: map['saturates'] ?? 0,
    );
  }

  Fat add(Fat addition) {
    return Fat(
      total + addition.total,
      saturates: saturates + addition.saturates,
    );
  }

  Fat multiply(double factor) {
    return Fat(
      total * factor,
      saturates: saturates * factor,
    );
  }
}

class Carbohydrates {
  final num total;
  final num sugars;

  const Carbohydrates(
    this.total, {
    this.sugars = 0,
  }) : assert(sugars <= total);

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'sugars': sugars,
    };
  }

  static Carbohydrates fromMap(Map<String, dynamic> map) {
    return Carbohydrates(
      map['total'],
      sugars: map['sugars'] ?? 0,
    );
  }

  Carbohydrates add(Carbohydrates addition) {
    return Carbohydrates(
      total + addition.total,
      sugars: sugars + addition.sugars,
    );
  }

  Carbohydrates multiply(double factor) {
    return Carbohydrates(
      total * factor,
      sugars: sugars * factor,
    );
  }
}
