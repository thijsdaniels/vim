import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/ingredient_consumption.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/collection_group.dart';

class ConsumptionsCollectionGroup extends CollectionGroup<Consumption> {
  static ConsumptionsCollectionGroup instance = ConsumptionsCollectionGroup();

  ConsumptionsCollectionGroup() : super(path: 'consumptions');

  @override
  Consumption fromFirestore(snapshot, options) {
    return Consumption.fromFirestore(snapshot, options);
  }

  Stream<List<IngredientConsumption>> forIngredient(
    Ingredient ingredient, {
    required User user,
    Timestamp? before,
    int? limit,
  }) {
    var query = collectionGroup
        .where('user', isEqualTo: user.reference)
        .where('ingredient.reference', isEqualTo: ingredient.reference)
        .where('timestamp', isLessThan: before)
        .orderBy('timestamp', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => doc.data() as IngredientConsumption)
        .toList());
  }
}
