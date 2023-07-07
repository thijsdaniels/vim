import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/service.dart';

class RecipesService extends Service<Recipe> {
  static RecipesService of(BuildContext context) {
    return Provider.of<RecipesService>(context, listen: false);
  }

  RecipesService(User? user)
      : super(
            path: user != null
                ? 'users/${user.reference!.id}/recipes'
                : 'recipes');

  @override
  Recipe fromFirestore(snapshot, options) {
    return Recipe.fromSnapshot(snapshot);
  }
}
