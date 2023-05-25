import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/nutrition.dart';

extension ConsumptionsListExtension on List<Consumption> {
  Nutrition get nutrition {
    return isNotEmpty
        ? map((consumption) => consumption.nutrition)
            .reduce((total, entry) => total + entry)
        : const Nutrition(calories: 0);
  }
}
