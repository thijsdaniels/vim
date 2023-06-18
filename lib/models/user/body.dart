import 'package:vim/models/model.dart';

enum Gender {
  male,
  female,
}

class Body extends Model {
  Gender? gender;
  int? age;
  int? length;
  double weight;
  final BodyComposition composition;

  Body({
    this.gender,
    this.age,
    required this.weight,
    this.length,
    required this.composition,
  }) : assert(
          composition.lean != null ||
              (composition.fat != null && composition.bone != null) ||
              (gender != null && length != null),
          'Either lean mass, or fat and bone mass, or gender and length must be provided.',
        );

  double get leanMass {
    if (composition.lean != null) {
      return weight * (composition.lean!);
    }

    if (composition.fat != null && composition.bone != null) {
      return weight * (1 - (composition.fat!) - (composition.bone!));
    }

    if (gender != null && length != null) {
      switch (gender!) {
        case Gender.male:
          return 0.407 * weight + 0.267 * length! - 19.2;
        case Gender.female:
          return 0.252 * weight + 0.473 * length! - 48.3;
      }
    }

    throw Exception('Unable to determine lean mass.');
  }

  double get bmr => 370 + (21.6 * leanMass);

  static Body fromMap(Map<String, dynamic> map) {
    return Body(
      age: map['age'],
      gender:
          map['gender'] != null ? Gender.values.byName(map['gender']) : null,
      length: map['length'],
      weight: map['weight'],
      composition: BodyComposition.fromMap(map['composition']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'gender': gender?.name,
      'length': length,
      'weight': weight,
      'composition': composition.toMap(),
    };
  }
}

class BodyComposition extends Model {
  double? lean;
  double? fat;
  double? bone;

  BodyComposition({
    this.lean,
    this.fat,
    this.bone,
  });

  static BodyComposition fromMap(Map<String, dynamic> map) {
    return BodyComposition(
      lean: map['lean'],
      fat: map['fat'],
      bone: map['bone'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'lean': lean,
      'fat': fat,
      'bone': bone,
    };
  }
}

// Body copyWith({
//   Gender? gender,
//   double? age,
//   double? length,
//   double? weight,
//   double? muscle,
//   double? fat,
//   double? neat,
//   double? surplus,
//   int? exercise,
//   double? proteinGramsPerKilo,
//   double? fats,
//   bool? adjustIntake,
// }) {
//   return Body(
//     gender: gender ?? this.gender,
//     age: age ?? this.age,
//     length: length ?? this.length,
//     weight: weight ?? this.weight,
//     muscle: muscle ?? this.muscle,
//     fat: fat ?? this.fat,
//     neat: neat ?? this.neat,
//     surplus: surplus ?? this.surplus,
//     exercise: exercise ?? this.exercise,
//     proteinGramsPerKilo: proteinGramsPerKilo ?? this.proteinGramsPerKilo,
//     fats: fats ?? this.fats,
//     adjustIntake: adjustIntake ?? this.adjustIntake,
//   );
// }
