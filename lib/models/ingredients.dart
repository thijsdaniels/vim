import 'package:vim/models/collection.dart';
import 'package:vim/models/ingredient.dart';

class Ingredients extends Collection<Ingredient> {
  final List<Ingredient> _ingredients;

  @override
  int get length => _ingredients.length;

  Ingredients([this._ingredients = const []]);

  @override
  Ingredient get(int index) {
    return _ingredients[index];
  }

  @override
  List<Map<String, dynamic>> toMap() {
    return _ingredients.map((ingredient) => ingredient.toMap()).toList();
  }

  static Ingredients fromMap(Map<String, dynamic> map) {
    return Ingredients(
      map['ingredients'].map((map) => Ingredient.fromMap(map)),
    );
  }

  @override
  Iterable<E> map<E>(E Function(Ingredient) toElement) {
    return _ingredients.map(toElement);
  }
}
