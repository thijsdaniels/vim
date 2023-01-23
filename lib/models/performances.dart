import 'package:vim/models/performance.dart';

class Performances {
  final List<Performance> _performances;

  int get length => _performances.length;

  int get calories {
    return _performances.isNotEmpty
        ? _performances
            .map((performance) => performance.calories)
            .reduce((total, entry) => total + entry)
        : 0;
  }

  Performances(this._performances);

  Performance get(int index) {
    return _performances[index];
  }
}
