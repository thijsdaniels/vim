import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/food/amount.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/nutrition.dart';

/// TODO: I think I had a good reason for making this class _implement_ the
/// `Consumption` class rather than extending it, but I forgot what that was and
/// I think I should give that another go, because I think it would make more
/// sense.
/// EDIT: This is because the base class has a `name` and `nutrition` attribute
/// that are required by the constructor, while this subclass actually defers
/// those to the related `ingredient`. I should probably make the base class
/// more abstract, and add a `QuickConsumption` subclass to replace the current
/// use case of the `Consumption` class.
class IngredientConsumption implements Consumption {
  DocumentReference? _reference;
  @override
  Timestamp timestamp;
  IngredientSnapshot ingredient;
  Amount amount;

  @override
  DocumentReference? get reference => _reference;

  @override
  String get name => ingredient.snapshot.name;

  @override
  Nutrition get nutrition => ingredient.snapshot.nutritionForAmount(amount);

  @override
  set name(String name) {
    ingredient.snapshot.name = name;
  }

  @override
  set nutrition(Nutrition nutrition) {
    ingredient.snapshot.nutrition = nutrition;
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
