import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/food/amount.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/models/model.dart';
import 'package:vim/services/ingredients_collection_group.dart';

class IngredientAmount extends Model {
  Ingredient? _ingredient;

  // TODO: Turn this into a `DocumentReference<Ingredient>`.
  final DocumentReference ingredientReference;
  final num amount;

  /// TODO: Turn this into a `Stream<Ingredient?>` for real-time updates.
  Future<Ingredient> get ingredient async {
    _ingredient ??= await IngredientsCollectionGroup.instance
        .get(ingredientReference.path)
        .first;

    return _ingredient!;
  }

  Future<Nutrition> get nutrition async {
    return (await ingredient).nutritionForAmount(Amount.grams(amount));
  }

  IngredientAmount({
    required this.ingredientReference,
    required this.amount,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'ingredient': ingredientReference,
      'amount': amount,
    };
  }

  static IngredientAmount fromMap(Map<String, dynamic> map) {
    return IngredientAmount(
      ingredientReference: map['ingredient'],
      amount: map['amount'],
    );
  }

  int compareTo(IngredientAmount other) {
    return (amount - other.amount).toInt();
  }

  IngredientAmount operator *(num factor) {
    return IngredientAmount(
      ingredientReference: ingredientReference,
      amount: amount * factor,
    );
  }
}
