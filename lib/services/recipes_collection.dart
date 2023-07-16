import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/services/collection.dart';

class RecipesCollection extends Collection<Recipe> {
  static RecipesCollection of(BuildContext context) {
    return Provider.of<RecipesCollection>(context, listen: false);
  }

  RecipesCollection({required super.path});

  @override
  Recipe fromFirestore(snapshot, options) {
    return Recipe.fromFirestore(snapshot, options);
  }

  @override
  Stream<List<Recipe>> all() {
    return collection
        .orderBy('name')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
