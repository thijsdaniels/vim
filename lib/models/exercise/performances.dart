import 'package:vim/models/collection.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/resistance_exercise_performance.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/models/exercise/weights_exercise_performance.dart';

class Performances extends MutableCollection<Performance> {
  const Performances([super.entries = const []]);

  Future<num> get calories async {
    return entries.isNotEmpty
        ? entries
            .map((performance) => performance.calories)
            .reduce((total, entry) async => await total + await entry)
        : Future(() => 0);
  }

  // TODO: Implement the `fromMap` if I ever need it. Keep in mind that it
  // needs to instantiate either `Performance`, `ExercisePerformance` or
  // `RoutinePerformance` depending on the data, and that this logic is already
  // defined in the `PerformancesService` so it would be good to avoid
  // repetition.
  factory Performances.fromMap(List<dynamic> list) {
    return Performances(
      list.map<Performance>(performanceFromMap).toList(),
    );
  }
}

Performance performanceFromMap(dynamic map) {
  if (map['exercise'] != null) {
    return exercisePerformanceFromMap(map);
  } else if (map['routine'] != null) {
    return RoutinePerformance.fromMap(map);
  } else {
    return Performance.fromMap(map);
  }
}

ExercisePerformance exercisePerformanceFromMap(dynamic map) {
  switch (ExerciseType.values.byName(map['exercise']['type'])) {
    case ExerciseType.manual:
      return ExercisePerformance.fromMap(map);
    case ExerciseType.resistance:
      return ResistanceExercisePerformance.fromMap(map);
    case ExerciseType.weights:
      return WeightsExercisePerformance.fromMap(map);
  }
}
