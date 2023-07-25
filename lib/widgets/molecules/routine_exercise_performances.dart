import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/exercises_collection_group.dart';
import 'package:vim/widgets/atoms/exercise_icon.dart';
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
    return StreamBuilder(
      stream: ExercisesCollectionGroup.instance.all(),
      builder: (context, exercises) {
        return StreamBuilder(
          stream: routinePerformance.performances,
          builder: (context, snapshot) {
            List<ExercisePerformance>? performances = snapshot.data;

            return StandardList(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              spacing: 12,
              itemCount:
                  routinePerformance.routine.snapshot.exerciseReferences.length,
              itemBuilder: (context, index) {
                DocumentReference exerciseReference = routinePerformance
                    .routine.snapshot.exerciseReferences[index];
                String exerciseId = exerciseReference.id;

                Exercise? exercise = exercises.data?.firstWhereOrNull(
                  (exercise) => exercise.reference?.id == exerciseId,
                );

                ExercisePerformance? performance =
                    performances?.firstWhereOrNull(
                  (performance) =>
                      performance.reference?.id ==
                      routinePerformance
                          .performanceReferences[index.toString()]?.id,
                );

                return StreamBuilder(
                  stream: exercise?.equipment,
                  builder: (context, equipment) {
                    return ListSurface(
                      elevation: 4,
                      icon: ExerciseIcon(exercise, elevation: 8),
                      title: exercise?.name ?? '',
                      subtitle: equipment.data?.name,
                      onTap: () async {
                        ExercisePerformance? edited =
                            await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CreateExercisePerformanceView(
                              exercise: performance == null ? exercise : null,
                              exercisePerformance: performance,
                            ),
                          ),
                        );

                        if (edited != null) {
                          if (edited.reference != null) {
                            routinePerformance.updatePerformance(edited);
                          } else {
                            routinePerformance.addPerformance(index, edited);
                          }
                        }
                      },
                      actions: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (exercise != null)
                            PerformedCheckbox(
                              routinePerformance: routinePerformance,
                              index: index,
                              exercise: exercise,
                              exercisePerformance: performance,
                            ),
                        ],
                      ),
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
    required this.routinePerformance,
    required this.index,
    required this.exercise,
    required this.exercisePerformance,
  });

  final RoutinePerformance routinePerformance;
  final int index;
  final Exercise exercise;
  final ExercisePerformance? exercisePerformance;

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder: (context, user, _) => Checkbox(
        value: exercisePerformance != null,
        onChanged: (value) async {
          if (value!) {
            ExercisePerformance? performance = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CreateExercisePerformanceView(
                  exercise: exercise,
                ),
              ),
            );

            if (performance != null) {
              routinePerformance.addPerformance(index, performance);
            }
          } else {
            routinePerformance.deletePerformance(exercisePerformance!);
          }
        },
      ),
    );
  }
}
