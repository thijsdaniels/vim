import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/services/service.dart';

class IngredientsService extends Service<Ingredient> {
  static IngredientsService of(BuildContext context) {
    return Provider.of<IngredientsService>(context, listen: false);
  }

  IngredientsService({required super.path});

  @override
  Ingredient fromFirestore(snapshot, options) {
    return Ingredient.fromSnapshot(snapshot);
  }

  @override
  Stream<List<Ingredient>> all() {
    return collection.orderBy('name').snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }
}
