import 'package:vim/extensions/sets.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/set.dart';
import 'package:vim/models/mass.dart';

/// TODO: Delete this class in favor of relating `Equipment` to an
/// `ExercisePerformance`.
class ResistanceExercisePerformance extends ExercisePerformance {
  Mass? bodyweight;
  List<Set> sets = [];

  /// TODO: Remove the legacy fallback of 65 kilograms for bodyweight and make
  /// the bodyweight after migrating old performances.
  /// TODO: If there is no equipment, I'm falling back to a loadFactor of 1, but
  /// It should actually be 0. I need to migrate old performances (those before
  /// 2023-07-21) to relate them to equipment.
  @override
  num get calories {
    var bodyweight = this.bodyweight ?? const Mass.kilograms(65);

    return sets.map((set) {
      var totalWeight = set.weight +
          exercise.snapshot.bodyweightFactor * bodyweight.kilograms;

      var bilateralRepetitions = exercise.snapshot.isUnilateral
          ? set.repetitions * 2
          : set.repetitions;

      /// The magic values `0.05` and `0.225` are reverse-engineered from the
      /// the MyWellness app developed by TechnoGym. The calculation is
      /// undoubtedly inaccuracte, but it is a decent starting point if nothing
      /// else.
      return 5 + bilateralRepetitions * 0.05 * totalWeight * 0.225;
    }).reduce((total, calories) => total + calories);
  }

  ResistanceExercisePerformance({
    required super.user,
    required super.timestamp,
    required super.exercise,
    required this.bodyweight,
    required this.sets,
  });

  static ResistanceExercisePerformance fromMap(Map<String, dynamic> map) {
    return ResistanceExercisePerformance(
      user: map['user'],
      timestamp: map['timestamp'],
      exercise: ExerciseSnapshot.fromMap(map['exercise']),
      bodyweight:
          map['bodyweight'] != null ? Mass.fromMap(map['bodyweight']) : null,
      sets: Sets.fromMap(map['sets']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'bodyweight': bodyweight?.toMap(),
      'sets': sets.toMap(),
    };
  }
}
