import 'package:fuzzy/fuzzy.dart';
import 'package:vim/models/food/recipe.dart';

extension Recipes on List<Recipe> {
  Fuzzy<Recipe> toFuzzy() {
    return Fuzzy(
      this,
      options: FuzzyOptions(
        keys: [
          WeightedKey(
            name: "name",
            getter: (recipe) => recipe.name,
            weight: 1,
          ),
        ],
        shouldNormalize: true,
      ),
    );
  }
}
