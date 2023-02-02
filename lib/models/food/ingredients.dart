import 'package:vim/models/collection.dart';
import 'package:vim/models/food/ingredient.dart';

class Ingredients extends Collection<Ingredient> {
  Ingredients(super.entries);

  // static Ingredients fromMap(Iterable<Map<String, dynamic>> map) {
  //   return Ingredients(
  //     map.map((map) => Ingredient.fromMap(map)).toList(),
  //   );
  // }
}
