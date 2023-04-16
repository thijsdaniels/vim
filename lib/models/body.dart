import 'package:vim/models/exercise/performances.dart';

enum Gender {
  male,
  female,
}

class Body {
  final Gender? gender;
  final double? age;
  final double? length;
  final double weight;
  final double? muscle;
  final double? fat;
  final double neat;
  final double surplus;
  final int exercise;
  // final double carbohydrates; // as a percentage of daily caloric intake
  final double proteinGramsPerKilo; // in grams per kilogram of bodyweight
  final double fats; // as a percentage of daily caloric intake
  final bool adjustIntake;

  Body({
    required this.gender,
    required this.age,
    required this.weight,
    required this.length,
    required this.muscle,
    required this.fat,
    required this.neat,
    required this.surplus,
    required this.exercise,
    // required this.carbohydrates,
    required this.proteinGramsPerKilo,
    required this.fats,
    this.adjustIntake = true,
  }) : assert(
          fat != null || (gender != null && length != null),
          'Either "fat" or the combination of "gender", "age" and "length" must be provided.',
        );

  double get proteins => proteinGramsPerKilo * weight * 4 / intake;

  double get carbohydrates => 1 - fats - proteins;

  double get leanMass {
    if (fat != null) {
      return weight * (1 - (fat! / 100));
    }

    if (gender != null && length != null) {
      switch (gender!) {
        case Gender.male:
          return 0.407 * weight + 0.267 * length! - 19.2;
        case Gender.female:
          return 0.252 * weight + 0.473 * length! - 48.3;
      }
    }

    throw Exception();
  }

  double get bmr => 370 + (21.6 * leanMass);

  double get intake => (bmr + neat) * (1 + surplus);

  Future<double> adjustedIntake(Performances performances) async {
    return adjustIntake ? intake + await performances.calories : intake;
  }

  Body copyWith({
    Gender? gender,
    double? age,
    double? length,
    double? weight,
    double? muscle,
    double? fat,
    double? neat,
    double? surplus,
    int? exercise,
    // double? carbohydrates,
    double? proteinGramsPerKilo,
    double? fats,
    bool? adjustIntake,
  }) {
    return Body(
      gender: gender ?? this.gender,
      age: age ?? this.age,
      length: length ?? this.length,
      weight: weight ?? this.weight,
      muscle: muscle ?? this.muscle,
      fat: fat ?? this.fat,
      neat: neat ?? this.neat,
      surplus: surplus ?? this.surplus,
      exercise: exercise ?? this.exercise,
      // carbohydrates: carbohydrates ?? this.carbohydrates,
      proteinGramsPerKilo: proteinGramsPerKilo ?? this.proteinGramsPerKilo,
      fats: fats ?? this.fats,
      adjustIntake: adjustIntake ?? this.adjustIntake,
    );
  }
}
