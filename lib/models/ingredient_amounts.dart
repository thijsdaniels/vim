import 'package:vim/models/ingredient.dart';
import 'package:vim/models/nutrition.dart';

class IngredientAmounts {
  final List<IngredientAmount> _ingredientAmounts;

  int get length => _ingredientAmounts.length;

  num get amount {
    return _ingredientAmounts
        .map((ingredientAmount) => ingredientAmount.amount)
        .reduce((total, amount) => total + amount);
  }

  Nutrition get nutrition {
    return _ingredientAmounts
        .map((ingredientAmount) => ingredientAmount.nutrition)
        .reduce((total, entry) => total.add(entry));
  }

  IngredientAmounts([this._ingredientAmounts = const []]);

  IngredientAmount get(int index) {
    return _ingredientAmounts[index];
  }

  Iterable<Map<String, dynamic>> toMap() {
    return _ingredientAmounts
        .map((ingredientAmount) => ingredientAmount.toMap());
  }

  static IngredientAmounts fromMap(List<dynamic> map) {
    return IngredientAmounts(
      map.map((map) => IngredientAmount.fromMap(map)).toList(),
    );
  }

  Nutrition nutritionForAmount(num amount) {
    double factor = amount / this.amount;

    return _ingredientAmounts
        .map((ingredientAmount) => ingredientAmount.nutrition.multiply(factor))
        .reduce((total, nutrition) => total.add(nutrition));
  }

  // Iterable<T> map<T>(T Function(IngredientAmount) toElement) {
  //   return _ingredientAmounts.map(toElement);
  // }

  // void add(IngredientAmount ingredientAmount) {
  //   return _ingredientAmounts.add(ingredientAmount);
  // }
}

class IngredientAmount {
  final Ingredient ingredient;
  final num amount;

  Nutrition get nutrition {
    return ingredient.nutritionForAmount(amount);
  }

  IngredientAmount({
    required this.ingredient,
    required this.amount,
  });

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
}
