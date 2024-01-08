import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/document.dart';
import 'package:vim/models/food/amount.dart';
import 'package:vim/models/food/ingredient_consumption.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/models/mass.dart';
import 'package:vim/models/snapshot.dart';
import 'package:vim/models/user/user.dart';

class Ingredient extends NamedDocument {
  String? icon;
  String? brand;
  num? serving;
  Nutrition nutrition;
  bool nutritionPerServing;

  Ingredient({
    required super.user,
    this.icon,
    required super.name,
    this.brand,
    this.serving,
    required this.nutrition,
    this.nutritionPerServing = false,
  }) : assert(!nutritionPerServing || serving != null,
            "A serving size must be provided if the nutrition is provided per serving.");

  factory Ingredient.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return Ingredient.fromMap(snapshot.data()!)
      ..reference = snapshot.reference.withConverter<Ingredient>(
        fromFirestore: Ingredient.fromFirestore,
        toFirestore: (exercise, _) => exercise.toMap(),
      );
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      user: map['user'],
      icon: map['icon'],
      name: map['name'],
      brand: map['brand'],
      serving: map['serving'],
      nutrition: Nutrition.fromMap(map['nutrition']),
      nutritionPerServing: map['nutritionPerServing'] ?? false,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'icon': icon,
      'name': name,
      'brand': brand,
      'serving': serving,
      'nutrition': nutrition.toMap(),
      'nutritionPerServing': nutritionPerServing,
    };
  }

  IngredientConsumption consumption({
    required User user,
    required Timestamp timestamp,
    required Amount amount,
  }) {
    return IngredientConsumption(
      user: user.reference!,
      timestamp: timestamp,
      ingredient: toSnapshot(),
      amount: amount,
    );
  }

  IngredientSnapshot toSnapshot() {
    return IngredientSnapshot(this);
  }

  Nutrition nutritionForAmount(Amount amount) {
    num weightForNutrition = nutritionPerServing ? serving! : 100;
    Nutrition nutritionPerGram = nutrition * (1 / weightForNutrition);
    return nutritionPerGram * weightForAmount(amount).grams;
  }

  Mass weightForAmount(Amount amount) {
    switch (amount.unit) {
      case Unit.grams:
        return Mass.grams(amount.value);
      case Unit.servings:
        if (serving == null) {
          throw Exception('Serving size for ingredient "$name" unknown.');
        }
        return Mass.grams(amount.value * serving!);
    }
  }
}

class IngredientSnapshot extends Snapshot<Ingredient> {
  IngredientSnapshot(
    super.snapshot, {
    super.reference,
  });

  static IngredientSnapshot fromMap(Map<String, dynamic> map) {
    return IngredientSnapshot(
      Ingredient.fromMap(map['snapshot']),
      reference: map['reference'],
    );
  }
}
