import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/services/collection.dart';

class IngredientsCollection extends Collection<Ingredient> {
  static IngredientsCollection of(BuildContext context) {
    return Provider.of<IngredientsCollection>(context, listen: false);
  }

  IngredientsCollection({required super.path});

  @override
  Ingredient fromFirestore(snapshot, options) {
    return Ingredient.fromFirestore(snapshot, options);
  }

  @override
  Stream<List<Ingredient>> all() {
    return collection
        .orderBy('name')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
