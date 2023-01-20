import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/ingredient_consumption.dart';
import 'package:vim/models/nutrition.dart';

class Ingredient {
  static final CollectionReference<Ingredient> _collection = FirebaseFirestore
      .instance
      .collection('ingredients')
      .withConverter<Ingredient>(
        fromFirestore: (snapshot, _) => Ingredient.fromSnapshot(snapshot),
        toFirestore: (ingredient, _) => ingredient.toMap(),
      );

  DocumentReference? _reference;

  String name;
  String? brand;
  Nutrition nutrition;

  Ingredient({
    required this.name,
    this.brand,
    required this.nutrition,
  });

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

    Ingredient consumption = fromMap(map);
    consumption._reference = snapshot.reference;

    return consumption;
  }

  static Ingredient fromMap(Map<String, dynamic> map) {
    return Ingredient(
      name: map['name'],
      brand: map['brand'],
      nutrition: Nutrition.fromMap(map['nutrition']),
    );
  }

  Future<void> save() async {
    if (_reference == null) {
      _reference = await _collection.add(this);
    } else {
      await _reference!.set(toMap());
    }
  }

  Future<void> delete() async {
    await _reference?.delete();
  }

  static Future<List<Ingredient>> all() async {
    QuerySnapshot<Ingredient> snapshot = await _collection.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  IngredientConsumption consumption(double amount) {
    return IngredientConsumption(
      ingredient: this,
      amount: amount,
    );
  }
}
