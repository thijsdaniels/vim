import 'package:vim/models/collection.dart';
import 'package:vim/models/recipe.dart';

class Recipes extends Collection<Recipe> {
  final List<Recipe> _recipes;

  @override
  int get length => _recipes.length;

  Recipes([this._recipes = const []]);

  @override
  Recipe get(int index) {
    return _recipes[index];
  }

  @override
  List<Map<String, dynamic>> toMap() {
    return _recipes.map((recipe) => recipe.toMap()).toList();
  }

  static Recipes fromMap(Map<String, dynamic> map) {
    return Recipes(
      map['recipes'].map((map) => Recipe.fromMap(map)),
    );
  }

  @override
  Iterable<E> map<E>(E Function(Recipe) toElement) {
    return _recipes.map(toElement);
  }
}
