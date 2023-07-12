import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/ingredient_consumption.dart';
import 'package:vim/models/food/recipe_consumption.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/service.dart';

class ConsumptionsService extends Service<Consumption> {
  static ConsumptionsService of(BuildContext context) {
    return Provider.of<ConsumptionsService>(context, listen: false);
  }

  ConsumptionsService(User user)
      : super(path: 'users/${user.reference!.id}/consumptions');

  @override
  Consumption fromFirestore(snapshot, options) {
    Map<String, dynamic> data = snapshot.data()!;

    if (data['recipe'] != null) {
      return RecipeConsumption.fromSnapshot(snapshot);
    } else if (data['ingredient'] != null) {
      return IngredientConsumption.fromSnapshot(snapshot);
    } else {
      return Consumption.fromSnapshot(snapshot);
    }
  }

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

  Stream<List<IngredientConsumption>> forIngredient(
    Ingredient ingredient, {
    Timestamp? before,
    int? limit,
  }) {
    var query = collection
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
