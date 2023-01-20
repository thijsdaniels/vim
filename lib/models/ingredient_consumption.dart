import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/consumption.dart';
import 'package:vim/models/ingredient.dart';
import 'package:vim/models/nutrition.dart';

class IngredientConsumption implements Consumption {
  static final CollectionReference<IngredientConsumption> _collection =
      FirebaseFirestore.instance
          .collection('ingredientConsumptions')
          .withConverter<IngredientConsumption>(
            fromFirestore: (snapshot, _) =>
                IngredientConsumption.fromSnapshot(snapshot),
            toFirestore: (consumption, _) => consumption.toMap(),
          );

  DocumentReference? _reference;

  @override
  late Timestamp timestamp;
  Ingredient ingredient;
  num amount;

  @override
  String get name => ingredient.name;

  @override
  Nutrition get nutrition => ingredient.nutrition.multiply(0.01 * amount);

  @override
  set name(String name) {
    ingredient.name = name;
  }

  @override
  set nutrition(Nutrition nutrition) {
    ingredient.nutrition = nutrition;
  }

  IngredientConsumption({
    Timestamp? timestamp,
    required this.ingredient,
    required this.amount,
  }) {
    this.timestamp = timestamp ?? Timestamp.now();
  }

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
    ingredientConsumption._reference = snapshot.reference;

    return ingredientConsumption;
  }

  static IngredientConsumption fromMap(Map<String, dynamic> map) {
    return IngredientConsumption(
      timestamp: map['timestamp'],
      ingredient: Ingredient.fromMap(map['ingredient']),
      amount: map['amount'],
    );
  }

  @override
  Future<void> save() async {
    if (_reference == null) {
      _reference = await _collection.add(this);
    } else {
      await _reference!.set(toMap());
    }
  }

  @override
  Future<void> delete() async {
    await _reference?.delete();
  }

  static Future<List<IngredientConsumption>> forDate(DateTime date) async {
    DateTime today = DateTime(date.year, date.month, date.day);
    DateTime tomorrow = today.add(const Duration(days: 1));

    QuerySnapshot<IngredientConsumption> snapshot = await _collection
        .where(
          'timestamp',
          isGreaterThanOrEqualTo: Timestamp.fromDate(today),
          isLessThan: Timestamp.fromDate(tomorrow),
        )
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
