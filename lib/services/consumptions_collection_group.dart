import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/ingredient_consumption.dart';
import 'package:vim/models/food/quick_consumption.dart';
import 'package:vim/models/food/recipe_consumption.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/services/collection_group.dart';

class ConsumptionsCollectionGroup extends CollectionGroup<Consumption> {
  static ConsumptionsCollectionGroup instance = ConsumptionsCollectionGroup();

  ConsumptionsCollectionGroup() : super(path: 'consumptions');

  /// TODO: This duplicates code from the `ConsumptionsService` class.
  /// TODO: Move this logic into the `Consumption.fromSnapshot` function?
  @override
  Consumption fromFirestore(snapshot, options) {
    Map<String, dynamic> data = snapshot.data()!;

    if (data['recipe'] != null) {
      return RecipeConsumption.fromSnapshot(snapshot);
    } else if (data['ingredient'] != null) {
      return IngredientConsumption.fromSnapshot(snapshot);
    } else {
      return QuickConsumption.fromSnapshot(snapshot);
    }
  }

  /// TODO: This query will include ingredient consumptions from other users. It
  /// should be limited to the current user.
  Stream<List<IngredientConsumption>> forIngredient(
    Ingredient ingredient, {
    Timestamp? before,
    int? limit,
  }) {
    var query = collectionGroup
        .where('ingredient.reference', isEqualTo: ingredient.reference)
        .where('timestamp', isLessThan: before)
        .orderBy('timestamp', descending: true);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => doc.data() as IngredientConsumption)
              .toList(),
        );
  }
}
