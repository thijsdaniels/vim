import 'package:vim/models/collection.dart';
import 'package:vim/models/exercise/performance.dart';

class Performances extends Collection<Performance> {
  Performances([super.entries = const []]);

  num get calories {
    return entries.isNotEmpty
        ? entries
            .map((performance) => performance.calories)
            .reduce((total, entry) => total + entry)
        : 0;
  }

  /// TODO: Implement the `fromMap` if I ever need it. Keep in mind that it
  /// needs to instantiate either `Performance`, `ExercisePerformance` or
  /// `RoutinePerformance` depending on the data, and that this logic is already
  /// defined in the `PerformancesService` so it would be good to avoid
  /// repetition.
  // static Performances fromMap(Iterable<Map<String, dynamic>> map) {
  //   return Performances(
  //     map.map((map) => Performance.fromMap(map)).toList(),
  //   );
  // }
}
