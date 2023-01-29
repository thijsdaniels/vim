import 'package:vim/models/performances.dart';

enum Gender {
  male,
  female,
}

class Settings {
  final Gender? gender;
  final double? age;
  final double? length;
  final double weight;
  final double? muscle;
  final double? fat;
  final double neat;
  final double surplus;
  final double exercise;
  final double carbohydrates;
  final double proteins;
  final double fats;
  final bool adjustIntake;

  Settings({
    required this.gender,
    required this.age,
    required this.weight,
    required this.length,
    required this.muscle,
    required this.fat,
    required this.neat,
    required this.surplus,
    required this.exercise,
    required this.carbohydrates,
    required this.proteins,
    required this.fats,
    this.adjustIntake = true,
  }) : assert(
          fat != null || (gender != null && length != null),
          'Either "fat" or the combination of "gender", "age" and "length" must be provided.',
        );

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

  double adjustedIntake(Performances performances) {
    return adjustIntake ? intake + performances.calories : intake;
  }
}
