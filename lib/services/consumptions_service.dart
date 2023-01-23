import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/consumption.dart';
import 'package:vim/models/consumptions.dart';
import 'package:vim/models/ingredient_consumption.dart';
import 'package:vim/models/recipe_consumption.dart';

/// TODO: Filter all operations by the currently authenticated user. It might be
/// a good idea to apply this generally to the entire service:
/// ```
///   instance
///     .collection('users')
///     .document(user.uid)
///     .collection('consumptions')
///     ...
/// ```
class ConsumptionsService {
  static final CollectionReference<Consumption> _collection = FirebaseFirestore
      .instance
      .collection('consumptions')
      .withConverter<Consumption>(
        fromFirestore: (snapshot, _) {
          Map<String, dynamic> data = snapshot.data()!;

          if (data['recipe'] != null) {
            return RecipeConsumption.fromSnapshot(snapshot);
          } else if (data['ingredient'] != null) {
            return IngredientConsumption.fromSnapshot(snapshot);
          } else {
            return Consumption.fromSnapshot(snapshot);
          }
        },
        toFirestore: (consumption, _) => consumption.toMap(),
      );

  static Stream<Consumptions> forDate(DateTime date) {
    DateTime today = DateTime(date.year, date.month, date.day);
    DateTime tomorrow = today.add(const Duration(days: 1));

    return _collection
        .where(
          'timestamp',
          isGreaterThanOrEqualTo: Timestamp.fromDate(today),
          isLessThan: Timestamp.fromDate(tomorrow),
        )
        .snapshots()
        .map((snapshot) =>
            Consumptions(snapshot.docs.map((doc) => doc.data()).toList()));
  }

  static Future<void> create(Consumption consumption) async {
    assert(consumption.id == null);
    return _collection.doc().set(consumption);
  }

  static Future<void> update(Consumption consumption) async {
    assert(consumption.id != null);
    return _collection.doc(consumption.id).set(consumption);
  }

  static Future<void> delete(Consumption consumption) async {
    assert(consumption.id != null);
    return _collection.doc(consumption.id).delete();
  }
}
