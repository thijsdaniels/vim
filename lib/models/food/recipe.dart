import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/food/amount.dart';
import 'package:vim/models/food/ingredient_amounts.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/models/food/recipe_consumption.dart';
import 'package:vim/models/model.dart';

class Recipe extends Model {
  String? _id;
  String name;
  num servings;
  IngredientAmountsReference ingredientAmounts;

  String? get id => _id;

  Future<Nutrition> get nutrition async {
    return ingredientAmounts.nutrition;
  }

  Recipe({
    required this.name,
    this.servings = 1,
    IngredientAmountsReference? ingredientAmounts,
  }) : ingredientAmounts = ingredientAmounts ?? IngredientAmountsReference([]);

  @override
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

class ResolvedRecipe extends Model {
  String name;
  num servings;
  IngredientAmounts ingredientAmounts;

  ResolvedRecipe({
    required this.name,
    this.servings = 1,
    required this.ingredientAmounts,
  });

  Nutrition get nutrition => ingredientAmounts.nutrition;

  Nutrition nutritionForAmount(Amount amount) {
    return ingredientAmountsForAmount(amount).nutrition;
  }

  IngredientAmounts ingredientAmountsForAmount(Amount amount) {
    switch (amount.unit) {
      case Unit.grams:
        return ingredientAmounts.forAmount(amount.value);
      case Unit.servings:
        return ingredientAmounts
            .forAmount((amount.value / servings) * ingredientAmounts.amount);
    }
  }

  @override
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
