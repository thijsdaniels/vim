import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/ingredient_amounts.dart';
import 'package:vim/models/recipe_consumption.dart';
import 'package:vim/models/nutrition.dart';

class Recipe {
  String? _id;
  String name;
  IngredientAmountsReference ingredientAmounts;

  String? get id => _id;

  Future<Nutrition> get nutrition async {
    return ingredientAmounts.nutrition;
  }

  Recipe({
    required this.name,
    required this.ingredientAmounts,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
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
      ingredientAmounts:
          IngredientAmountsReference.fromMap(map['ingredientAmounts']),
    );
  }

  Future<RecipeConsumption> consumption({
    required Timestamp timestamp,
    required double amount,
  }) async {
    return RecipeConsumption(
      timestamp: timestamp,
      recipe: await resolve(),
      amount: amount,
    );
  }

  Future<Nutrition> nutritionForAmount(num amount) async {
    return ingredientAmounts.nutritionForAmount(amount);
  }

  Future<ResolvedRecipe> resolve() async {
    return ResolvedRecipe(
      name: name,
      ingredientAmounts: await ingredientAmounts.resolve(),
    );
  }
}

class ResolvedRecipe {
  String name;
  IngredientAmounts ingredientAmounts;

  ResolvedRecipe({required this.name, required this.ingredientAmounts});

  Nutrition get nutrition => ingredientAmounts.nutrition;

  Nutrition nutritionForAmount(num amount) {
    return ingredientAmounts.nutritionForAmount(amount);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ingredientAmounts': ingredientAmounts.toMap(),
    };
  }

  static ResolvedRecipe fromMap(Map<String, dynamic> map) {
    return ResolvedRecipe(
      name: map['name'],
      ingredientAmounts: IngredientAmounts.fromMap(map['ingredientAmounts']),
    );
  }
}
