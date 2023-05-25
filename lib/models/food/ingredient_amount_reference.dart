import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/food/amount.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/ingredient_amount.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/models/model.dart';

class IngredientAmountReference extends Model {
  Ingredient? _ingredient;

  final DocumentReference ingredientReference;
  final num amount;

  /// TODO: Turn this into a Stream<Ingredient?> for real-time updates.
  Future<Ingredient> get ingredient async {
    _ingredient ??= (await ingredientReference
            .withConverter(
              fromFirestore: (snapshot, _) => Ingredient.fromSnapshot(snapshot),
              toFirestore: (ingredient, _) => ingredient.toMap(),
            )
            .get())
        .data();
    return _ingredient!;
  }

  Future<Nutrition> get nutrition async {
    return (await ingredient).nutritionForAmount(Amount.grams(amount));
  }

  IngredientAmountReference({
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

  static IngredientAmountReference fromMap(Map<String, dynamic> map) {
    return IngredientAmountReference(
      ingredientReference: map['ingredient'],
      amount: map['amount'],
    );
  }

  Future<IngredientAmount> resolve() async {
    return IngredientAmount(
      ingredient: await ingredient,
      amount: amount,
    );
  }
}
