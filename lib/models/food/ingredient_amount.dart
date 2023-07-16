import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/food/amount.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/models/model.dart';

class IngredientAmount extends Model {
  Ingredient? _ingredient;

  // TODO: Turn this into a `DocumentReference<Ingredient>`.
  final DocumentReference ingredientReference;
  final num amount;

  /// TODO: Find a more sustainable way to do this, ideally via the
  /// `IngredientsCollection`.
  /// TODO: Turn this into a `Stream<Ingredient?>` for real-time updates.
  Future<Ingredient> get ingredient async {
    _ingredient ??= (await ingredientReference
            .withConverter<Ingredient>(
              fromFirestore: Ingredient.fromFirestore,
              toFirestore: (ingredient, _) => ingredient.toMap(),
            )
            .get())
        .data();

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

  IngredientAmount operator *(num factor) {
    return IngredientAmount(
      ingredientReference: ingredientReference,
      amount: amount * factor,
    );
  }
}
