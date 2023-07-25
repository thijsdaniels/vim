import 'dart:async';

import 'package:collection/collection.dart';
import 'package:vim/models/food/ingredient_amount.dart';
import 'package:vim/models/food/nutrition.dart';

extension IngredientAmounts on List<IngredientAmount> {
  num get amount {
    if (isEmpty) {
      return 0;
    } else {
      return map((ingredientAmount) => ingredientAmount.amount)
          .reduce((total, amount) => total + amount);
    }
  }

  Future<Nutrition> get nutrition async {
    if (isEmpty) {
      return Nutrition.empty;
    }

    return map((ingredientAmount) => ingredientAmount.nutrition)
        .reduce((total, entry) async => await total + await entry);
  }

  Future<Nutrition> nutritionForAmount(num amount) async {
    num factor = amount / this.amount;

    return map(
      (ingredientAmount) async => await ingredientAmount.nutrition * factor,
    ).reduce(
      (total, nutrition) async => await total + await nutrition,
    );
  }

  List<IngredientAmount> forAmount(num amount) {
    num factor = amount / this.amount;

    return map((ingredientAmount) => ingredientAmount * factor).toList();
  }

  List<dynamic> toMap() {
    return map((ingredientAmount) => ingredientAmount.toMap()).toList();
  }

  static List<IngredientAmount> fromMap(List<dynamic> list) {
    return list.map((map) => IngredientAmount.fromMap(map)).toList();
  }

  List<IngredientAmount> sortedByWeight() {
    return sorted((a, b) => b.compareTo(a));
  }
}
