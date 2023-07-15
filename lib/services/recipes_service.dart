import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/services/service.dart';

class RecipesService extends Service<Recipe> {
  static RecipesService of(BuildContext context) {
    return Provider.of<RecipesService>(context, listen: false);
  }

  RecipesService({required super.path});

  @override
  Recipe fromFirestore(snapshot, options) {
    return Recipe.fromSnapshot(snapshot);
  }

  @override
  Stream<List<Recipe>> all() {
    return collection.orderBy('name').snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }
}
