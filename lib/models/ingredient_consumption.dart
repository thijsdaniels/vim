import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/consumption.dart';
import 'package:vim/models/ingredient.dart';
import 'package:vim/models/nutrition.dart';

class IngredientConsumption implements Consumption {
  String? _id;
  @override
  Timestamp timestamp;
  Ingredient ingredient;
  num amount;

  @override
  String? get id => _id;

  @override
  String get name => ingredient.name;

  @override
  Nutrition get nutrition => ingredient.nutritionForAmount(amount);

  @override
  set name(String name) {
    ingredient.name = name;
  }

  @override
  set nutrition(Nutrition nutrition) {
    ingredient.nutrition = nutrition;
  }

  IngredientConsumption({
    required this.timestamp,
    required this.ingredient,
    required this.amount,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'ingredient': ingredient.toMap(),
      'amount': amount,
    };
  }

  static IngredientConsumption fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    IngredientConsumption ingredientConsumption = fromMap(map);
    ingredientConsumption._id = snapshot.id;

    return ingredientConsumption;
  }

  static IngredientConsumption fromMap(Map<String, dynamic> map) {
    return IngredientConsumption(
      timestamp: map['timestamp'],
      ingredient: Ingredient.fromMap(map['ingredient']),
      amount: map['amount'],
    );
  }
}
