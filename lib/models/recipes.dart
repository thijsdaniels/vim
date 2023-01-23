import 'package:vim/models/recipe.dart';

class Recipes {
  final List<Recipe> _recipes;

  int get length => _recipes.length;

  Recipes(this._recipes);

  Recipe get(int index) {
    return _recipes[index];
  }

  Iterable<Map<String, dynamic>> toMap() {
    return _recipes.map((recipe) => recipe.toMap());
  }

  static Recipes fromMap(Map<String, dynamic> map) {
    return Recipes(
      map['recipes'].map((map) => Recipe.fromMap(map)),
    );
  }
}
