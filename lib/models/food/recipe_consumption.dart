import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/food/amount.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/ingredient_amounts.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/models/food/nutrition.dart';

/// TODO: I think I had a good reason for making this class _implement_ the
/// `Consumption` class rather than extending it, but I forgot what that was and
/// I think I should give that another go, because I think it would make more
/// sense.
/// EDIT: This is because the base class has a `name` and `nutrition` attribute
/// that are required by the constructor, while this subclass actually defers
/// those to the related `recipe`. I should probably make the base class more
/// abstract, and add a `QuickConsumption` subclass to replace the current use
/// case of the `Consumption` class.
class RecipeConsumption implements Consumption {
  DocumentReference? _reference;
  @override
  Timestamp timestamp;
  ResolvedRecipe recipe;
  Amount amount;

  @override
  DocumentReference? get reference => _reference;

  @override
  String get name => recipe.name;

  @override
  Nutrition get nutrition => recipe.nutritionForAmount(amount);

  IngredientAmounts get ingredientAmounts =>
      recipe.ingredientAmountsForAmount(amount);

  @override
  set name(String name) {
    recipe.name = name;
  }

  @override
  set nutrition(Nutrition nutrition) {
    // TODO: Find a way to not have to implement the nutrition setter at all.
    throw Exception("A recipe's nutritional value cannot be edited directly.");
  }

  RecipeConsumption({
    required this.timestamp,
    required this.recipe,
    required this.amount,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'recipe': recipe.toMap(),
      'amount': amount.toMap(),
    };
  }

  static RecipeConsumption fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    RecipeConsumption recipeConsumption = fromMap(map);
    recipeConsumption._reference = snapshot.reference;

    return recipeConsumption;
  }

  static RecipeConsumption fromMap(Map<String, dynamic> map) {
    return RecipeConsumption(
      timestamp: map['timestamp'],
      recipe: ResolvedRecipe.fromMap(map['recipe']),
      amount: Amount.fromMap(map['amount']),
    );
  }
}
