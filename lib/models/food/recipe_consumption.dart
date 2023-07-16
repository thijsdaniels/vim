import 'dart:async';

import 'package:vim/extensions/consumptions.dart';
import 'package:vim/models/food/amount.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/ingredient_amount.dart';
import 'package:vim/models/food/ingredient_consumption.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/services/consumptions_collection.dart';

class RecipeConsumption extends Consumption {
  RecipeSnapshot recipe;
  Amount amount;

  @override
  String get name => recipe.snapshot.name;

  ConsumptionsCollection<IngredientConsumption>? get consumptionsCollection {
    if (reference == null) {
      return null;
    }

    return ConsumptionsCollection<IngredientConsumption>(
      path: '${reference!.path}/consumptions',
    );
  }

  Stream<List<IngredientConsumption>>? get consumptions {
    return consumptionsCollection?.all();
  }

  @override
  FutureOr<Nutrition> get nutrition async {
    return (await consumptions?.first)?.nutrition ?? Nutrition.empty;
  }

  List<IngredientAmount> get ingredientAmounts {
    return recipe.snapshot.ingredientAmountsForAmount(amount);
  }

  RecipeConsumption({
    required super.timestamp,
    required this.recipe,
    required this.amount,
  });

  @override
  Future<void> onCreate() async {
    await createIngredientConsumptions();
  }

  @override
  Future<void> onUpdate() async {
    await updateIngredientConsumptions();
  }

  @override
  Future<void> onDelete() async {
    await deleteIngredientConsumptions();
  }

  Future<void> createIngredientConsumptions() async {
    assert(consumptionsCollection != null);

    await Future.wait(ingredientAmounts.map((ingredientAmount) async {
      return consumptionsCollection!.create(IngredientConsumption(
        timestamp: timestamp,
        ingredient: IngredientSnapshot(await ingredientAmount.ingredient),
        amount: Amount.grams(ingredientAmount.amount),
      ));
    }));
  }

  /// TODO: Check if this approach is correct and even if it is, there's
  /// probably a more efficient way to do this.
  Future<void> updateIngredientConsumptions() async {
    assert(consumptionsCollection != null);

    await deleteIngredientConsumptions();
    await createIngredientConsumptions();
  }

  Future<void> deleteIngredientConsumptions() async {
    assert(consumptionsCollection != null);

    await Future.wait(
      (await consumptionsCollection!.all().first).map(
        (performance) => performance.reference!.delete(),
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'recipe': recipe.toMap(),
      'amount': amount.toMap(),
    };
  }

  static RecipeConsumption fromMap(Map<String, dynamic> map) {
    return RecipeConsumption(
      timestamp: map['timestamp'],
      recipe: RecipeSnapshot.fromMap(map['recipe']),
      amount: Amount.fromMap(map['amount']),
    );
  }
}
