import 'package:cloud_firestore/cloud_firestore.dart';

import 'consumption.dart';

class Ingredient {
  static final CollectionReference<Ingredient> _collection = FirebaseFirestore.instance
      .collection('ingredients')
      .withConverter<Ingredient>(
        fromFirestore: (snapshot, _) => Ingredient.fromSnapshot(snapshot),
        toFirestore: (ingredient, _) => ingredient.toMap(),
      );

  DocumentReference? _reference;

  final String name;
  final String? brand;
  final num calories;
  final num carbohydrates;
  final num protein;
  final num fat;

  Ingredient({
    required this.name,
    this.brand,
    required this.calories,
    this.carbohydrates = 0,
    this.protein = 0,
    this.fat = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'brand': brand,
      'calories': calories,
      'carbohydrates': carbohydrates,
      'protein': protein,
      'fat': fat,
    };
  }

  static Ingredient fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> map = snapshot.data()!;

    Ingredient consumption = fromMap(map);
    consumption._reference = snapshot.reference;

    return consumption;
  }

  static Ingredient fromMap(Map<String, dynamic> map) {
    return Ingredient(
      name: map['name'],
      brand: map['brand'],
      calories: map['calories'],
      carbohydrates: map['carbohydrates'],
      protein: map['protein'],
      fat: map['fat'],
    );
  }

  Future<void> save() async {
    _reference = await _collection.add(this);
  }

  Future<void> delete() async {
    await _reference?.delete();
  }

  static Future<List<Ingredient>> all() async {
    QuerySnapshot<Ingredient> snapshot = await _collection.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Consumption consumption(double amount) {
    return Consumption(
      name: name,
      calories: calories * 0.01 * amount,
      carbohydrates: carbohydrates * 0.01 * amount,
      protein: protein * 0.01 * amount,
      fat: fat * 0.01 * amount,
    );
  }
}
