class Nutrition {
  final num calories;
  final num carbohydrates;
  final num protein;
  final num fat;

  Nutrition({
    required this.calories,
    this.carbohydrates = 0,
    this.protein = 0,
    this.fat = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'calories': calories,
      'carbohydrates': carbohydrates,
      'protein': protein,
      'fat': fat,
    };
  }

  static Nutrition fromMap(Map<String, dynamic> map) {
    return Nutrition(
      calories: map['calories'],
      carbohydrates: map['carbohydrates'],
      protein: map['protein'],
      fat: map['fat'],
    );
  }

  Nutrition add(Nutrition addition) {
    return Nutrition(
      calories: calories + addition.calories,
      carbohydrates: carbohydrates + addition.carbohydrates,
      protein: protein + addition.protein,
      fat: fat + addition.fat,
    );
  }

  Nutrition multiply(double factor) {
    return Nutrition(
      calories: calories * factor,
      carbohydrates: carbohydrates * factor,
      protein: protein * factor,
      fat: fat * factor,
    );
  }
}
