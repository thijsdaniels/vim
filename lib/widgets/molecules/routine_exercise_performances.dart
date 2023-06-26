import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/extensions/num.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/resistance_exercise_performance.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/models/exercise/set.dart';
import 'package:vim/models/exercise/sets.dart';
import 'package:vim/models/exercise/weights_exercise_performance.dart';
import 'package:vim/services/performances_collection_group.dart';
import 'package:vim/widgets/atoms/muscle_groups_focus_icon.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:vim/widgets/views/home/log/exercise_log/create_exercise_performance_view.dart';

// TODO: This widget is a mess and should be refactored and abstracted.
class RoutineExercisePerformances extends StatelessWidget {
  const RoutineExercisePerformances({
    super.key,
    required this.routinePerformance,
  });

  final RoutinePerformance routinePerformance;

  @override
  Widget build(BuildContext context) {
    return Consumer<List<Exercise>>(
      builder: (context, exercises, _) {
        return StreamBuilder(
          stream: routinePerformance.performances,
          builder: (context, snapshot) {
            List<ExercisePerformance>? performances = snapshot.data;

            return StandardList(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: routinePerformance.routine.exerciseReferences.length,
              itemBuilder: (context, index) {
                DocumentReference exerciseReference =
                    routinePerformance.routine.exerciseReferences[index];
                String exerciseId = exerciseReference.id;

                Exercise? exercise = exercises.firstWhereOrNull(
                  (exercise) => exercise.reference?.id == exerciseId,
                );

                ExercisePerformance? performance =
                    performances?.firstWhereOrNull(
                  (performance) =>
                      performance.reference?.id ==
                      routinePerformance
                          .performanceReferences[index.toString()]?.id,
                );

                return StreamBuilder<Iterable<Performance>>(
                  stream: exercise != null
                      ? PerformancesCollectionGroup.instance.forExercise(
                          exercise,
                          before: routinePerformance.timestamp,
                          limit: 1,
                        )
                      : null,
                  builder: (context, snapshot) {
                    ExercisePerformance? latest =
                        snapshot.data != null && snapshot.data!.isNotEmpty
                            ? snapshot.data!.first as ExercisePerformance
                            : null;

                    return ListSurface(
                      elevation: 4,
                      icon: MuscleGroupsFocusIcon(
                        elevation: 8,
                        primary: exercise?.muscleGroups.primary,
                        secondary: exercise?.muscleGroups.secondary ?? [],
                      ),
                      onTap: performance != null
                          ? () async {
                              ExercisePerformance edited =
                                  await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CreateExercisePerformanceView(
                                    exercisePerformance: performance,
                                  ),
                                ),
                              );

                              routinePerformance.updatePerformance(edited);
                            }
                          : null,
                      actions: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (exercise != null)
                            PerformedCheckbox(
                              index: index,
                              exercise: exercise,
                              exercisePerformance: performance,
                              previousExercisePerformance: latest,
                              routinePerformance: routinePerformance,
                            ),
                        ],
                      ),
                      title: Text(exercise?.name ?? '',
                          overflow: TextOverflow.ellipsis),
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
                                  builder: (context, snapshot) => SecondaryText(
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
                                            .map((set) => '${set.repetitions}')
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
                    );
                  },
                );
              },
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
                exercise: exercise.toSnapshot(),
                calories: await previousExercisePerformance?.calories ?? 0,
              );
              break;
            case ExerciseType.resistance:
              exercisePerformance = ResistanceExercisePerformance(
                timestamp: Timestamp.now(),
                exercise: exercise.toSnapshot(),
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
                exercise: exercise.toSnapshot(),
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
