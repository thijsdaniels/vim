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
  PlannedExercises plan;

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
      plan: PlannedExercises.fromMap(map['plan']),
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
    );
  }
}

class PlannedExercises extends MutableCollection<PlannedExercise> {
  PlannedExercises([super.entries = const []]);

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

  static PlannedExercises fromMap(Iterable<dynamic> map) {
    return PlannedExercises(
      map.map((map) => PlannedExercise.fromMap(map)).toList(),
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
class PlannedExercise extends Model {
  DocumentReference? exerciseReference;

  num? calories;
  num? minutes; // TODO: Turn this into a `Duration`.
  num? watts;
  Sets sets;

  Future<Exercise?> get exercise async {
    return exerciseReference != null
        ? ExercisesService.get(exerciseReference!.id).first
        : null;
  }

  PlannedExercise({
    this.exerciseReference,
    this.calories,
    this.minutes,
    this.watts,
    this.sets = const Sets(),
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'exercise': exerciseReference,
      if (calories != null) 'calories': calories,
      if (minutes != null) 'minutes': minutes,
      if (watts != null) 'watts': watts,
      if (sets.isNotEmpty) 'sets': sets.toMap(),
    };
  }

  static PlannedExercise fromMap(Map<String, dynamic> map) {
    return PlannedExercise(
      exerciseReference: map['exercise'],
      calories: map['calories'],
      minutes: map['minutes'],
      watts: map['watts'],
      sets: Sets.fromMap(map['sets']),
    );
  }
}

class ResolvedRoutine extends Model {
  String name;

  num get calories => 0; // TODO: Get calories from exercise list.

  ResolvedRoutine({
    required this.name,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  static ResolvedRoutine fromMap(Map<String, dynamic> map) {
    return ResolvedRoutine(
      name: map['name'],
    );
  }
}
