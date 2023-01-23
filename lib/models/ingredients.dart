import 'package:vim/models/ingredient.dart';

class Ingredients {
  final List<Ingredient> _ingredients;

  int get length => _ingredients.length;

  Ingredients([this._ingredients = const []]);

  Ingredient get(int index) {
    return _ingredients[index];
  }

  Iterable<Map<String, dynamic>> toMap() {
    return _ingredients.map((ingredient) => ingredient.toMap());
  }

  static Ingredients fromMap(Map<String, dynamic> map) {
    return Ingredients(
      map['ingredients'].map((map) => Ingredient.fromMap(map)),
    );
  }
}
