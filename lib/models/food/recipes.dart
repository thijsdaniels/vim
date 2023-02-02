import 'package:vim/models/collection.dart';
import 'package:vim/models/food/recipe.dart';

class Recipes extends Collection<Recipe> {
  Recipes(super.entries);

  // static Recipes fromMap(Iterable<Map<String, dynamic>> map) {
  //   return Recipes(
  //     map.map((map) => Recipe.fromMap(map)).toList(),
  //   );
  // }
}
