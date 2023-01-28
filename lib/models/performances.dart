import 'package:vim/models/collection.dart';
import 'package:vim/models/performance.dart';

class Performances extends Collection<Performance> {
  final List<Performance> _performances;

  @override
  int get length => _performances.length;

  int get calories {
    return _performances.isNotEmpty
        ? _performances
            .map((performance) => performance.calories)
            .reduce((total, entry) => total + entry)
        : 0;
  }

  Performances([this._performances = const []]);

  @override
  List<Map<String, dynamic>> toMap() {
    return _performances.map((performance) => performance.toMap()).toList();
  }

  @override
  Performance get(int index) {
    return _performances[index];
  }

  @override
  Iterable<E> map<E>(E Function(Performance) toElement) {
    return _performances.map(toElement);
  }
}
