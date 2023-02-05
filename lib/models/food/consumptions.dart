import 'package:vim/models/collection.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/nutrition.dart';

class Consumptions extends Collection<Consumption> {
  Consumptions([super.entries = const []]);

  /// TODO: Implement the `fromMap` if I ever need it. Keep in mind that it
  /// needs to instantiate either `Consumption`, `IngredientConsumption` or
  /// `RecipeConsumption` depending on the data, and that this logic is already
  /// defined in the `ConsumptionsService` so it would be good to avoid
  /// repetition.
  // static Consumptions fromMap(Iterable<Map<String, dynamic>> map) {
  //   return Consumptions(
  //     map.map((map) => Consumption.fromMap(map)).toList(),
  //   );
  // }

  Nutrition get nutrition {
    return entries.isNotEmpty
        ? entries
            .map((consumption) => consumption.nutrition)
            .reduce((total, entry) => total + entry)
        : const Nutrition(calories: 0);
  }
}
