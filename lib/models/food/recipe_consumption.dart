import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/extensions/consumptions.dart';
import 'package:vim/models/food/amount.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/ingredient_amount.dart';
import 'package:vim/models/food/ingredient_consumption.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/services/consumptions_service.dart';

class RecipeConsumption extends Consumption {
  DocumentReference? _reference;

  RecipeSnapshot recipe;
  Amount amount;

  @override
  DocumentReference? get reference => _reference;

  @override
  String get name => recipe.snapshot.name;

  ConsumptionsService<IngredientConsumption>? get consumptionsService {
    if (_reference == null) {
      return null;
    }

    return ConsumptionsService(
      path: '${_reference!.path}/consumptions',
    );
  }

  Stream<List<IngredientConsumption>>? get consumptions {
    return consumptionsService?.all();
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
  Future<void> onCreate(reference) async {
    _reference = reference;
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
    assert(consumptionsService != null);

    await Future.wait(ingredientAmounts.map((ingredientAmount) async {
      return consumptionsService!.create(IngredientConsumption(
        timestamp: timestamp,
        ingredient: IngredientSnapshot(
          Ingredient.fromSnapshot(
            (await ingredientAmount.ingredientReference.get()
                as DocumentSnapshot<Map<String, dynamic>>),
          ),
        ),
        amount: Amount.grams(ingredientAmount.amount),
      ));
    }));
  }

  /// TODO: Check if this approach is correct and even if it is, there's
  /// probably a more efficient way to do this.
  Future<void> updateIngredientConsumptions() async {
    assert(consumptionsService != null);

    await deleteIngredientConsumptions();
    await createIngredientConsumptions();
  }

  Future<void> deleteIngredientConsumptions() async {
    assert(consumptionsService != null);

    await Future.wait(
      (await consumptionsService!.all().first).map(
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
      recipe: RecipeSnapshot.fromMap(map['recipe']),
      amount: Amount.fromMap(map['amount']),
    );
  }
}
