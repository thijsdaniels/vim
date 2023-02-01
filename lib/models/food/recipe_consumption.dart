import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/food/amount.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/models/food/nutrition.dart';

class RecipeConsumption implements Consumption {
  String? _id;
  @override
  Timestamp timestamp;
  ResolvedRecipe recipe;
  Amount amount;

  @override
  String? get id => _id;

  @override
  String get name => recipe.name;

  @override
  Nutrition get nutrition => recipe.nutritionForAmount(amount);

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
    recipeConsumption._id = snapshot.id;

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
