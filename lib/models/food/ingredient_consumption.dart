import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/food/amount.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/nutrition.dart';

class IngredientConsumption extends Consumption {
  DocumentReference? _reference;

  IngredientSnapshot ingredient;
  Amount amount;

  @override
  DocumentReference? get reference => _reference;

  @override
  String get name => ingredient.snapshot.name;

  @override
  FutureOr<Nutrition> get nutrition {
    return ingredient.snapshot.nutritionForAmount(amount);
  }

  IngredientConsumption({
    required super.timestamp,
    required this.ingredient,
    required this.amount,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'ingredient': ingredient.toMap(),
      'amount': amount.toMap(),
    };
  }

  static IngredientConsumption fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    IngredientConsumption ingredientConsumption = fromMap(map);
    ingredientConsumption._reference = snapshot.reference;

    return ingredientConsumption;
  }

  static IngredientConsumption fromMap(Map<String, dynamic> map) {
    return IngredientConsumption(
      timestamp: map['timestamp'],
      ingredient: IngredientSnapshot.fromMap(map['ingredient']),
      amount: Amount.fromMap(map['amount']),
    );
  }
}
