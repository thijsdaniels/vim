import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/ingredient_consumption.dart';
import 'package:vim/models/food/recipe_consumption.dart';
import 'package:vim/services/service.dart';

/// TODO: Filter all operations by the currently authenticated user. It might be
/// a good idea to apply this generally to the entire service:
/// ```
///   instance
///     .collection('users')
///     .document(user.uid)
///     .collection('consumptions')
///     ...
/// ```
class ConsumptionsService extends Service<Consumption> {
  static final instance = ConsumptionsService();

  @override
  final CollectionReference<Consumption> collection = FirebaseFirestore.instance
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

  Stream<List<Consumption>> forDate(DateTime date) {
    DateTime today = DateTime(date.year, date.month, date.day);
    DateTime tomorrow = today.add(const Duration(days: 1));

    return collection
        .where(
          'timestamp',
          isGreaterThanOrEqualTo: Timestamp.fromDate(today),
          isLessThan: Timestamp.fromDate(tomorrow),
        )
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
