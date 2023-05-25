import 'package:vim/models/collection.dart';
import 'package:vim/models/food/ingredient_amount.dart';
import 'package:vim/models/food/ingredient_amount_reference.dart';
import 'package:vim/models/food/ingredient_amounts.dart';
import 'package:vim/models/food/nutrition.dart';

/// TODO: Turn into an extension of List<IngredientAmountReference>
class IngredientAmountsReference
    extends MutableCollection<IngredientAmountReference> {
  IngredientAmountsReference([super.entries = const []]) {
    entries.sort((a, b) => a.amount > b.amount ? -1 : 1);
  }

  num get amount {
    if (entries.isEmpty) {
      return 0;
    } else {
      return entries
          .map((ingredientAmount) => ingredientAmount.amount)
          .reduce((total, amount) => total + amount);
    }
  }

  Future<Nutrition> get nutrition async {
    if (entries.isEmpty) {
      return Nutrition.zero;
    }

    return entries
        .map((ingredientAmount) => ingredientAmount.nutrition)
        .reduce((total, entry) async => await total + await entry);
  }

  static IngredientAmountsReference fromMap(Iterable<dynamic> map) {
    return IngredientAmountsReference(
      map.map((map) => IngredientAmountReference.fromMap(map)).toList(),
    );
  }

  Future<Nutrition> nutritionForAmount(num amount) async {
    num factor = amount / this.amount;

    return entries
        .map(
          (ingredientAmount) async => await ingredientAmount.nutrition * factor,
        )
        .reduce(
          (total, nutrition) async => await total + await nutrition,
        );
  }

  Future<IngredientAmounts> resolve() async {
    List<IngredientAmount> ingredientAmounts = await Future.wait(
      entries.map(
        (ingredientAmount) async => await ingredientAmount.resolve(),
      ),
    );

    return IngredientAmounts(ingredientAmounts);
  }
}
