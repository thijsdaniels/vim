import 'package:vim/models/collection.dart';
import 'package:vim/models/exercise/set.dart';

class Sets extends Collection<Set> {
  Sets([super.entries = const []]);

  static Sets fromMap(Iterable<dynamic> map) {
    return Sets(
      map.map((map) => Set.fromMap(map)).toList(),
    );
  }

  num get calories => entries
      .map((set) => set.calories)
      .reduce((total, calories) => total + calories);
}
