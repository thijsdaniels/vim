import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/document.dart';
import 'package:vim/models/food/ingredient_consumption.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/models/food/quick_consumption.dart';
import 'package:vim/models/food/recipe_consumption.dart';

abstract class Consumption extends Document {
  Timestamp timestamp;

  String get name;
  FutureOr<Nutrition> get nutrition;

  Consumption({
    required this.timestamp,
  });

  factory Consumption.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return Consumption.fromMap(snapshot.data()!)
      ..reference = snapshot.reference.withConverter<Consumption>(
        fromFirestore: Consumption.fromFirestore,
        toFirestore: (exercise, _) => exercise.toMap(),
      );
  }

  factory Consumption.fromMap(Map<String, dynamic> map) {
    if (map['recipe'] != null) {
      return RecipeConsumption.fromMap(map);
    } else if (map['ingredient'] != null) {
      return IngredientConsumption.fromMap(map);
    } else {
      return QuickConsumption.fromMap(map);
    }
  }
}
