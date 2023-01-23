import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/ingredient_amounts.dart';
import 'package:vim/models/recipe_consumption.dart';
import 'package:vim/models/nutrition.dart';

class Recipe {
  String? _id;
  String name;
  IngredientAmounts ingredientAmounts;

  String? get id => _id;

  Nutrition get nutrition {
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
      ingredientAmounts: IngredientAmounts.fromMap(map['ingredientAmounts']),
    );
  }

  RecipeConsumption consumption({
    required Timestamp timestamp,
    required double amount,
  }) {
    return RecipeConsumption(
      timestamp: timestamp,
      recipe: this,
      amount: amount,
    );
  }

  Nutrition nutritionForAmount(num amount) {
    return ingredientAmounts.nutritionForAmount(amount);
  }
}
