import 'dart:async';

import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/nutrition.dart';

extension Consumptions on List<Consumption> {
  FutureOr<Nutrition> get nutrition {
    return isNotEmpty
        ? map((consumption) => consumption.nutrition)
            .reduce((total, entry) async => await total + await entry)
        : Nutrition.empty;
  }
}
