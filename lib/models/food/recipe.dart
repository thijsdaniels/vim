import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/extensions/ingredient_amounts.dart';
import 'package:vim/models/document.dart';
import 'package:vim/models/food/amount.dart';
import 'package:vim/models/food/ingredient_amount.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/models/food/recipe_consumption.dart';
import 'package:vim/models/snapshot.dart';
import 'package:vim/models/user/user.dart';

class Recipe extends OwnedDocument {
  String name;
  num servings;
  late List<IngredientAmount> ingredientAmounts;

  Future<Nutrition> get nutrition async {
    return ingredientAmounts.nutrition;
  }

  Recipe({
    required super.user,
    required this.name,
    this.servings = 1,
    List<IngredientAmount>? ingredientAmounts,
  }) : ingredientAmounts = ingredientAmounts?.sortedByWeight() ?? [];

  factory Recipe.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return Recipe.fromMap(snapshot.data()!)
      ..reference = snapshot.reference.withConverter<Recipe>(
        fromFirestore: Recipe.fromFirestore,
        toFirestore: (exercise, _) => exercise.toMap(),
      );
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      user: map['user'],
      name: map['name'],
      servings: map['servings'],
      ingredientAmounts: IngredientAmounts.fromMap(map['ingredientAmounts']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'name': name,
      'servings': servings,
      'ingredientAmounts': ingredientAmounts.toMap(),
    };
  }

  Future<Nutrition> nutritionForAmount(Amount amount) {
    switch (amount.unit) {
      case Unit.grams:
        return ingredientAmounts.nutritionForAmount(amount.value);
      case Unit.servings:
        return ingredientAmounts
            .nutritionForAmount(amount.value * ingredientAmounts.amount);
    }
  }

  List<IngredientAmount> ingredientAmountsForAmount(Amount amount) {
    switch (amount.unit) {
      case Unit.grams:
        return ingredientAmounts.forAmount(amount.value);
      case Unit.servings:
        return ingredientAmounts
            .forAmount((amount.value / servings) * ingredientAmounts.amount);
    }
  }

  Future<RecipeConsumption> consumption({
    required User user,
    required Timestamp timestamp,
    required Amount amount,
  }) async {
    return RecipeConsumption(
      user: user.reference!,
      timestamp: timestamp,
      recipe: toSnapshot(),
      amount: amount,
    );
  }

  RecipeSnapshot toSnapshot() {
    return RecipeSnapshot(this);
  }
}

class RecipeSnapshot extends Snapshot<Recipe> {
  RecipeSnapshot(
    super.snapshot, {
    super.reference,
  });

  static RecipeSnapshot fromMap(Map<String, dynamic> map) {
    return RecipeSnapshot(
      Recipe.fromMap(map['snapshot']),
      reference: map['reference'],
    );
  }
}
