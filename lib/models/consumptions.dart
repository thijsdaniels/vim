import 'package:vim/models/collection.dart';
import 'package:vim/models/consumption.dart';
import 'package:vim/models/nutrition.dart';

class Consumptions extends Collection<Consumption> {
  final List<Consumption> _consumptions;

  @override
  int get length => _consumptions.length;

  Nutrition get nutrition {
    return _consumptions.isNotEmpty
        ? _consumptions
            .map((consumption) => consumption.nutrition)
            .reduce((total, entry) => total.add(entry))
        : const Nutrition(calories: 0);
  }

  Consumptions([this._consumptions = const []]);

  @override
  Consumption get(int index) {
    return _consumptions[index];
  }

  @override
  Iterable<E> map<E>(E Function(Consumption) toElement) {
    return _consumptions.map(toElement);
  }

  @override
  List<Map<String, dynamic>> toMap() {
    return _consumptions.map((consumption) => consumption.toMap()).toList();
  }
}
