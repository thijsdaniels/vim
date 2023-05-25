import 'package:vim/models/collection.dart';
import 'package:vim/models/food/ingredient_amount.dart';
import 'package:vim/models/food/nutrition.dart';

/// TODO: Turn into an extension of List<IngredientAmount>
class IngredientAmounts extends Collection<IngredientAmount> {
  num get amount {
    return entries
        .map((ingredientAmount) => ingredientAmount.amount)
        .reduce((total, amount) => total + amount);
  }

  Nutrition get nutrition {
    return entries
        .map((ingredientAmount) => ingredientAmount.nutrition)
        .reduce((total, entry) => total + entry);
  }

  IngredientAmounts([super.entries = const []]);

  static IngredientAmounts fromMap(Iterable<dynamic> map) {
    return IngredientAmounts(
      map.map((map) => IngredientAmount.fromMap(map)).toList(),
    );
  }

  Nutrition nutritionForAmount(num amount) {
    num factor = amount / this.amount;

    return entries
        .map((ingredientAmount) => ingredientAmount.nutrition * factor)
        .reduce((total, nutrition) => total + nutrition);
  }

  IngredientAmounts forAmount(num amount) {
    num factor = amount / this.amount;

    return IngredientAmounts(
        entries.map((ingredientAmount) => ingredientAmount * factor).toList());
  }
}
