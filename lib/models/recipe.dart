import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/amount.dart';
import 'package:vim/models/ingredient_amounts.dart';
import 'package:vim/models/recipe_consumption.dart';
import 'package:vim/models/nutrition.dart';

class Recipe {
  String? _id;
  String name;
  int servings;
  IngredientAmountsReference ingredientAmounts;

  String? get id => _id;

  Future<Nutrition> get nutrition async {
    return ingredientAmounts.nutrition;
  }

  Recipe({
    required this.name,
    this.servings = 1,
    required this.ingredientAmounts,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'servings': servings,
      'ingredientAmounts': ingredientAmounts.toMap(),
    };
  }

  static Recipe fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    Recipe recipe = fromMap(map);
    recipe._id = snapshot.id;

    return recipe;
  }

  static Recipe fromMap(Map<String, dynamic> map) {
    return Recipe(
      name: map['name'],
      servings: map['servings'],
      ingredientAmounts:
          IngredientAmountsReference.fromMap(map['ingredientAmounts']),
    );
  }

  Future<RecipeConsumption> consumption({
    required Timestamp timestamp,
    required Amount amount,
  }) async {
    return RecipeConsumption(
      timestamp: timestamp,
      recipe: await resolve(),
      amount: amount,
    );
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

  Future<ResolvedRecipe> resolve() async {
    return ResolvedRecipe(
      name: name,
      servings: servings,
      ingredientAmounts: await ingredientAmounts.resolve(),
    );
  }
}

class ResolvedRecipe {
  String name;
  int servings;
  IngredientAmounts ingredientAmounts;

  ResolvedRecipe({
    required this.name,
    this.servings = 1,
    required this.ingredientAmounts,
  });

  Nutrition get nutrition => ingredientAmounts.nutrition;

  Nutrition nutritionForAmount(Amount amount) {
    switch (amount.unit) {
      case Unit.grams:
        return ingredientAmounts.nutritionForAmount(amount.value);
      case Unit.servings:
        return ingredientAmounts
            .nutritionForAmount(amount.value * ingredientAmounts.amount);
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'servings': servings,
      'ingredientAmounts': ingredientAmounts.toMap(),
    };
  }

  static ResolvedRecipe fromMap(Map<String, dynamic> map) {
    return ResolvedRecipe(
      name: map['name'],
      servings: map['servings'],
      ingredientAmounts: IngredientAmounts.fromMap(map['ingredientAmounts']),
    );
  }
}
