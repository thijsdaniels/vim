import 'dart:async';

import 'package:vim/models/food/amount.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/models/mass.dart';

class IngredientConsumption extends Consumption {
  IngredientSnapshot ingredient;
  Amount amount;

  @override
  String get name => ingredient.snapshot.name;

  Mass get weight => ingredient.snapshot.weightForAmount(amount);

  @override
  FutureOr<Nutrition> get nutrition {
    return ingredient.snapshot.nutritionForAmount(amount);
  }

  IngredientConsumption({
    required super.user,
    required super.timestamp,
    required this.ingredient,
    required this.amount,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'ingredient': ingredient.toMap(),
      'amount': amount.toMap(),
    };
  }

  static IngredientConsumption fromMap(Map<String, dynamic> map) {
    return IngredientConsumption(
      user: map['user'],
      timestamp: map['timestamp'],
      ingredient: IngredientSnapshot.fromMap(map['ingredient']),
      amount: Amount.fromMap(map['amount']),
    );
  }

  int compareTo(IngredientConsumption other) {
    var weightOrder = (weight - other.weight).grams.toInt();

    if (weightOrder != 0) {
      return weightOrder;
    } else {
      return other.name.compareTo(name);
    }
  }
}
