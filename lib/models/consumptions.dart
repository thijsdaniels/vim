import 'package:vim/models/consumption.dart';
import 'package:vim/models/nutrition.dart';

class Consumptions {
  final List<Consumption> _consumptions;

  int get length => _consumptions.length;

  Nutrition get nutrition {
    return _consumptions.isNotEmpty
        ? _consumptions
            .map((consumption) => consumption.nutrition)
            .reduce((total, entry) => total.add(entry))
        : Nutrition(calories: 0);
  }

  Consumptions(this._consumptions);

  Consumption get(int index) {
    return _consumptions[index];
  }
}
