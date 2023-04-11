import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';
import 'package:vim/extensions/num.dart';
import 'package:vim/models/collection.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/resistance_exercise_performance.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/models/exercise/set.dart';
import 'package:vim/models/exercise/sets.dart';
import 'package:vim/models/exercise/weights_exercise_performance.dart';
import 'package:vim/services/performances_service.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/views/home/log/exercise_log/create_exercise_performance_view.dart';

class RoutineExercisePerformances extends StatelessWidget {
  const RoutineExercisePerformances({
    super.key,
    required this.routinePerformance,
  });

  final RoutinePerformance routinePerformance;

  @override
  Widget build(BuildContext context) {
    return Consumer<Collection<Exercise>>(
      builder: (context, exercises, _) {
        return StreamBuilder(
          stream: routinePerformance.performances,
          builder: (context, snapshot) {
            List<ExercisePerformance>? performances = snapshot.data;

            return ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: routinePerformance.routine.exerciseReferences
                  .asMap()
                  .entries
                  .map(
                (entry) {
                  String id = entry.value.id;

                  Exercise? exercise = exercises.firstWhereOrNull(
                    (exercise) => exercise.reference?.id == id,
                  );

                  ExercisePerformance? performance =
                      performances?.firstWhereOrNull(
                    (performance) =>
                        performance.reference?.id ==
                        routinePerformance
                            .performanceReferences[entry.key.toString()]?.id,
                  );

                  return Card(
                    elevation: 4,
                    child: StreamBuilder<Performance>(
                      stream: exercise != null
                          ? PerformancesService.instance.latest(
                              name: exercise.name,
                              before: routinePerformance.timestamp,
                            )
                          : null,
                      builder: (context, snapshot) {
                        ExercisePerformance? latest =
                            snapshot.data as ExercisePerformance?;

                        return ListTile(
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (exercise != null)
                                PerformedCheckbox(
                                  index: entry.key,
                                  exercise: exercise,
                                  exercisePerformance: performance,
                                  previousExercisePerformance: latest,
                                  routinePerformance: routinePerformance,
                                ),
                            ],
                          ),
                          title: Text(exercise?.name ?? ''),
                          subtitle: performance != null
                              ? FutureBuilder(
                                  future: performance.calories,
                                  builder: (context, snapshot) => SecondaryText(
                                    // TODO: Try to change this into Chip widgets.
                                    [
                                      if (performance
                                              is! WeightsExercisePerformance &&
                                          performance
                                              is! ResistanceExercisePerformance)
                                        '${snapshot.data?.round()} cal',
                                      if (performance
                                          is WeightsExercisePerformance) ...[
                                        '${(performance.sets.weight / performance.sets.length).decimals(2)} kg',
                                        performance.sets
                                            .map((set) => '${set.repetitions}')
                                            .join("/"),
                                      ],
                                      if (performance
                                          is ResistanceExercisePerformance) ...[
                                        '${performance.watts} watts',
                                        '${performance.duration.inMinutes} m',
                                      ],

                                      /// TODO: Re-enable this.
                                      // if (latest != null)
                                      //   '${(snapshot.data ?? 0 / latest.calories * 100).round()}%'
                                    ].join(" • "),
                                  ),
                                )
                              : latest != null
                                  ? FutureBuilder(
                                      future: latest.calories,
                                      builder: (context, snapshot) =>
                                          SecondaryText(
                                        // TODO: Try to change this into Chip widgets.
                                        [
                                          if (latest
                                                  is! WeightsExercisePerformance &&
                                              latest
                                                  is! ResistanceExercisePerformance)
                                            '${snapshot.data?.round()} cal',
                                          if (latest
                                              is WeightsExercisePerformance) ...[
                                            '${(latest.sets.weight / latest.sets.length).decimals(2)} kg',
                                            latest.sets
                                                .map((set) =>
                                                    '${set.repetitions}')
                                                .join("/"),
                                          ],
                                          if (latest
                                              is ResistanceExercisePerformance) ...[
                                            '${latest.watts} watts',
                                            '${latest.duration.inMinutes} m',
                                          ],
                                        ].join(" • "),
                                      ),
                                    )
                                  : const SecondaryText('--'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (performance != null)
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () async {
                                    ExercisePerformance edited =
                                        await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CreateExercisePerformanceView(
                                          exercisePerformance: performance,
                                        ),
                                      ),
                                    );

                                    routinePerformance
                                        .updatePerformance(edited);
                                  },
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ).toList(),
            );
          },
        );
      },
    );
  }
}

class PerformedCheckbox extends StatelessWidget {
  const PerformedCheckbox({
    super.key,
    required this.index,
    required this.exercise,
    required this.exercisePerformance,
    required this.previousExercisePerformance,
    required this.routinePerformance,
  });

  final int index;
  final Exercise exercise;
  final ExercisePerformance? exercisePerformance;
  final ExercisePerformance? previousExercisePerformance;
  final RoutinePerformance routinePerformance;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: exercisePerformance != null,
      onChanged: (value) async {
        if (value!) {
          ExercisePerformance exercisePerformance;

          switch (exercise.type) {
            case ExerciseType.manual:
              exercisePerformance = ExercisePerformance(
                timestamp: Timestamp.now(),
                exercise: exercise,
                calories: await previousExercisePerformance?.calories ?? 0,
              );
              break;
            case ExerciseType.resistance:
              exercisePerformance = ResistanceExercisePerformance(
                timestamp: Timestamp.now(),
                exercise: exercise,
                duration: (previousExercisePerformance
                            as ResistanceExercisePerformance?)
                        ?.duration ??
                    Duration.zero,
                watts: (previousExercisePerformance
                            as ResistanceExercisePerformance?)
                        ?.watts ??
                    0,
              );
              break;
            case ExerciseType.weights:
              exercisePerformance = WeightsExercisePerformance(
                timestamp: Timestamp.now(),
                exercise: exercise,
                sets: Sets(
                  (previousExercisePerformance as WeightsExercisePerformance?)
                          ?.sets
                          .map(
                            (set) => Set(
                              weight: set.weight,
                              repetitions: set.repetitions,
                            ),
                          )
                          .toList() ??
                      [const Set(weight: 0, repetitions: 0)],
                ),
              );
              break;
          }

          routinePerformance.addPerformance(index, exercisePerformance);
        } else {
          routinePerformance.deletePerformance(exercisePerformance!);
        }
      },
    );
  }
}
