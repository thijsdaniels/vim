import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/food/amount.dart';
import 'package:vim/models/food/ingredient_consumption.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/models/model.dart';

class Ingredient extends Model {
  DocumentReference? _reference;
  String name;
  String? brand;
  num? serving;
  Nutrition nutrition;

  DocumentReference? get reference => _reference;

  Ingredient({
    required this.name,
    this.brand,
    this.serving,
    required this.nutrition,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'brand': brand,
      'serving': serving,
      'nutrition': nutrition.toMap(),
    };
  }

  static Ingredient fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    Ingredient ingredient = fromMap(map);
    ingredient._reference = snapshot.reference;

    return ingredient;
  }

  static Ingredient fromMap(Map<String, dynamic> map) {
    return Ingredient(
      name: map['name'],
      brand: map['brand'],
      serving: map['serving'],
      nutrition: Nutrition.fromMap(map['nutrition']),
    );
  }

  IngredientConsumption consumption({
    required Timestamp timestamp,
    required Amount amount,
  }) {
    return IngredientConsumption(
      timestamp: timestamp,
      ingredient: this,
      amount: amount,
    );
  }

  Nutrition nutritionForAmount(Amount amount) {
    return nutrition * 0.01 * _weightForAmount(amount);
  }

  num _weightForAmount(Amount amount) {
    switch (amount.unit) {
      case Unit.grams:
        return amount.value;
      case Unit.servings:
        if (serving == null) {
          throw Exception('Serving size for ingredient "$name" unknown.');
        }
        return amount.value * serving!;
    }
  }
}
