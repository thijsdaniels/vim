import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/collection.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/models/exercise/sets.dart';
import 'package:vim/models/model.dart';
import 'package:vim/services/exercises_service.dart';

class Routine extends Model {
  String? _id;

  String name;
  PlannedPerformances plan;

  String? get id => _id;

  Future<num> get calories => plan.calories;

  Routine({
    required this.name,
    required this.plan,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'plan': plan.toMap(),
    };
  }

  static Routine fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    Routine routine = fromMap(map);
    routine._id = snapshot.id;

    return routine;
  }

  static Routine fromMap(Map<String, dynamic> map) {
    return Routine(
      name: map['name'],
      plan: PlannedPerformances.fromMap(map['plan']),
    );
  }

  Future<RoutinePerformance> performance({
    required Timestamp timestamp,
  }) async {
    return RoutinePerformance(
      timestamp: timestamp,
      routine: await resolve(),
    );
  }

  /// TODO: Include the planned exercises.
  Future<ResolvedRoutine> resolve() async {
    return ResolvedRoutine(
      name: name,
      plan: await plan.resolve(),
    );
  }
}

class PlannedPerformances extends MutableCollection<PlannedPerformance> {
  PlannedPerformances([super.entries = const []]);

  Future<num> get calories async {
    if (entries.isEmpty) {
      return 0;
    }

    return entries.map((plannedExercise) async {
      var exercise = await plannedExercise.exercise;

      switch (exercise!.type) {
        case ExerciseType.manual:
          return plannedExercise.calories ?? 0;
        case ExerciseType.resistance:
          return -1; // TODO: Calculate calories.
        case ExerciseType.weights:
          return -1; // TODO: Calculate calories.
      }
    }).reduce((total, calories) async => (await total) + (await calories));
  }

  static PlannedPerformances fromMap(Iterable<dynamic> map) {
    return PlannedPerformances(
      map.map((map) => PlannedPerformance.fromMap(map)).toList(),
    );
  }

  /// TODO: This function is only needed because during the routine creation
  /// an empty Set is appended for the sake of filling in the form fields. I
  /// should find a better way, because this is starting to get really messy.
  PlannedPerformances trim() {
    return PlannedPerformances(
      entries.map((entry) {
        var sets = entry.sets
            ?.where((set) => set.repetitions != null && set.weight != null)
            .toList();
        entry.sets = sets != null && sets.isNotEmpty ? Sets(sets) : null;
        return entry;
      }).toList(),
    );
  }

  Future<ResolvedPlannedPerformances> resolve() async {
    return ResolvedPlannedPerformances(
      (await Future.wait(entries.map((entry) => entry.resolve()))).toList(),
    );
  }
}

/// TODO: This is kind of a duplicate of the various `ExercisePerformance`
/// models, with the main difference being that the properties are all optional
/// so that it can be used for form input state. It would of course be much nicer
/// to use the existing `Performance` models for this instead.
///
/// This will work very well as soon as I make those models able to store both a
/// reference to an exercise, _as well_ as a resolved exercise.
///
/// I want to do that anyway, so that you can both edit an exercise without
/// affecting earlier performances, as well as update a performance to the values
/// of the current version of the exercise.
class PlannedPerformance extends Model {
  DocumentReference? exerciseReference;

  num? calories;
  int? minutes; // TODO: Turn this into a `Duration`.
  num? watts;
  Sets? sets;

  Future<Exercise?> get exercise async {
    return exerciseReference != null
        ? ExercisesService.get(exerciseReference!.id).first
        : null;
  }

  PlannedPerformance({
    this.exerciseReference,
    this.calories,
    this.minutes,
    this.watts,
    this.sets,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'exercise': exerciseReference,
      if (calories != null) 'calories': calories,
      if (minutes != null) 'minutes': minutes,
      if (watts != null) 'watts': watts,
      if (sets != null && sets!.isNotEmpty) 'sets': sets!.toMap(),
    };
  }

  static PlannedPerformance fromMap(Map<String, dynamic> map) {
    return PlannedPerformance(
      exerciseReference: map['exercise'],
      calories: map['calories'],
      minutes: map['minutes'],
      watts: map['watts'],
      sets: map['sets'] ? Sets.fromMap(map['sets']) : null,
    );
  }

  Future<ResolvedPlannedPerformance> resolve() async {
    return ResolvedPlannedPerformance(
      exercise: await exercise,
      calories: calories,
      minutes: minutes,
      watts: watts,
      sets: sets,
    );
  }
}

class ResolvedRoutine extends Model {
  String name;
  ResolvedPlannedPerformances plan;

  num get calories => plan.calories;

  ResolvedRoutine({
    required this.name,
    required this.plan,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'plan': plan.toMap(),
    };
  }

  static ResolvedRoutine fromMap(Map<String, dynamic> map) {
    return ResolvedRoutine(
      name: map['name'],
      plan: ResolvedPlannedPerformances.fromMap(map['plan']),
    );
  }
}

class ResolvedPlannedPerformances
    extends MutableCollection<ResolvedPlannedPerformance> {
  ResolvedPlannedPerformances([super.entries = const []]);

  num get calories {
    if (entries.isEmpty) {
      return 0;
    }

    return entries.map((performance) {
      var exercise = performance.exercise;

      switch (exercise?.type) {
        case ExerciseType.manual:
          return performance.calories ?? 0;
        case ExerciseType.resistance:
        case ExerciseType.weights:

          /// TODO: Calculate the calories. Instead of moving the calculations
          /// to the `Exercise` class, I should just use the `Performance`
          /// classes instead of the `PlannedPerformance` classes (or make the
          /// `PlannedPerformance` inherit from `Performance`. Or maybe I should
          /// make the `Routine` keep the `PlannedPerformance`, but make the
          /// `RoutinePerformance` containe List<ExercisePerformance>. That
          /// might actually make the most sense.
          return 0;
        default:
          throw Exception('Missing exercise');
      }
    }).reduce((total, calories) => total + calories);
  }

  static ResolvedPlannedPerformances fromMap(Iterable<dynamic> map) {
    return ResolvedPlannedPerformances(
      map.map((map) => ResolvedPlannedPerformance.fromMap(map)).toList(),
    );
  }
}

class ResolvedPlannedPerformance extends Model {
  Exercise? exercise;

  num? calories;
  int? minutes; // TODO: Turn this into a `Duration`.
  num? watts;
  Sets? sets;

  ResolvedPlannedPerformance({
    this.exercise,
    this.calories,
    this.minutes,
    this.watts,
    this.sets,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'exercise': exercise?.toMap(),
      if (calories != null) 'calories': calories,
      if (minutes != null) 'minutes': minutes,
      if (watts != null) 'watts': watts,
      if (sets != null && sets!.isNotEmpty) 'sets': sets!.toMap(),
    };
  }

  static ResolvedPlannedPerformance fromMap(Map<String, dynamic> map) {
    return ResolvedPlannedPerformance(
      exercise: Exercise.fromMap(map['exercise']),
      calories: map['calories'],
      minutes: map['minutes'],
      watts: map['watts'],
      sets: map['sets'] != null ? Sets.fromMap(map['sets']) : null,
    );
  }
}
