import 'package:vim/models/collection.dart';
import 'package:vim/models/exercise/set.dart';

class Sets extends Collection<Set> {
  const Sets([super.entries = const []]);

  static Sets fromMap(Iterable<dynamic> list) {
    return Sets(
      list.map((map) => Set.fromMap(map)).toList(),
    );
  }

  num get calories => entries
      .map((set) => set.calories)
      .reduce((total, calories) => total + calories);

  num get repetitions => entries
      .map((set) => set.repetitions)
      .reduce((total, repetitions) => total + repetitions);

  num get weight => entries
      .map((set) => set.weight)
      .reduce((total, weight) => total + weight);
}
