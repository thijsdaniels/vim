import 'package:fuzzy/fuzzy.dart';
import 'package:vim/models/food/ingredient.dart';

extension Ingredients on List<Ingredient> {
  Fuzzy<Ingredient> toFuzzy() {
    return Fuzzy(
      this,
      options: FuzzyOptions(
        keys: [
          WeightedKey(
            name: "name",
            getter: (ingredient) => ingredient.name,
            weight: 2,
          ),
          WeightedKey(
            name: "brand",
            getter: (ingredient) => ingredient.brand ?? "",
            weight: 1,
          ),
        ],
        shouldNormalize: true,
      ),
    );
  }
}
