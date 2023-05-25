import 'package:vim/models/food/amount.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/models/model.dart';

class IngredientAmount extends Model {
  final Ingredient ingredient;
  final num amount; // TODO: Turn into an instance of Amount.

  Nutrition get nutrition {
    return ingredient.nutritionForAmount(Amount.grams(amount));
  }

  IngredientAmount({
    required this.ingredient,
    required this.amount,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'ingredient': ingredient.toMap(),
      'amount': amount,
    };
  }

  static IngredientAmount fromMap(Map<String, dynamic> map) {
    return IngredientAmount(
      ingredient: Ingredient.fromMap(map['ingredient']),
      amount: map['amount'],
    );
  }

  IngredientAmount operator *(num factor) {
    return IngredientAmount(ingredient: ingredient, amount: amount * factor);
  }
}
