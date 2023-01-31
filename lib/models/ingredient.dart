import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/ingredient_consumption.dart';
import 'package:vim/models/model.dart';
import 'package:vim/models/nutrition.dart';

class Ingredient extends Model {
  DocumentReference? _reference;
  String name;
  String? brand;
  Nutrition nutrition;

  DocumentReference? get reference => _reference;

  Ingredient({
    required this.name,
    this.brand,
    required this.nutrition,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'brand': brand,
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
      nutrition: Nutrition.fromMap(map['nutrition']),
    );
  }

  IngredientConsumption consumption({
    required Timestamp timestamp,
    required double amount,
  }) {
    return IngredientConsumption(
      timestamp: timestamp,
      ingredient: this,
      amount: amount,
    );
  }

  Nutrition nutritionForAmount(double amount) {
    return nutrition.multiply(0.01 * amount);
  }
}
