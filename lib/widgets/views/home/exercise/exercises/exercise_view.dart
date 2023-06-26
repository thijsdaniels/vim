import 'package:flutter/material.dart';
import 'package:vim/extensions/string.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/services/exercises_service.dart';
import 'package:vim/services/performances_service.dart';
import 'package:vim/widgets/atoms/exercise_muscle_groups.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/atoms/stats_table.dart';
import 'package:vim/widgets/molecules/performances_list.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';
import 'package:vim/widgets/views/home/exercise/exercises/create_exercise_view.dart';
import 'package:vim/widgets/views/loading_view.dart';
import 'package:vim/widgets/views/not_found_view.dart';

class ExerciseView extends StatelessWidget {
  final String exerciseId;

  const ExerciseView(
    this.exerciseId, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Exercise?>(
      stream: ExercisesService.instance.get(exerciseId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingView();
        }

        if (!snapshot.hasData) {
          return const NotFoundView();
        }

        Exercise exercise = snapshot.requireData!;

        return Scaffold(
          appBar: AppBar(
            title: Text(exercise.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_rounded),
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CreateExerciseView(
                        exercise: exercise,
                      ),
                    ),
                  );
                },
              ),
              WithConfirmationDialog(
                title: exercise.name,
                description: 'Are you sure you want to delete this exercise?',
                builder: (context, confirm) => IconButton(
                  icon: const Icon(Icons.delete_rounded),
                  onPressed: () async {
                    var navigator = Navigator.of(context);
                    if (await confirm()) {
                      ExercisesService.instance.delete(exercise);
                      navigator.pop();
                    }
                  },
                ),
              ),
            ],
          ),
          body: StandardList(
            children: [
              SimpleCard(
                title: 'Details',
                child: StatsTable(
                  children: [
                    StatsRow('Name', exercise.name),
                    StatsRow('Type', exercise.type.name.toTitleCase()),
                  ],
                ),
              ),
              ExerciseMuscleGroups(exercise: exercise),
              SimpleCard(
                title: 'Muscle Groups',
                child: StatsTable(
                  children: [
                    StatsRow(
                      'Primary',
                      exercise.muscleGroups.primary?.name.toTitleCase(),
                    ),
                    StatsRow(
                      'Secondary',
                      exercise.muscleGroups.secondary.isNotEmpty
                          ? exercise.muscleGroups.secondary
                              .map((muscleGroup) =>
                                  muscleGroup.name.toTitleCase())
                              .join(', ')
                          : null,
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                stream: PerformancesService.instance.forExercise(exercise),
                builder: (context, snapshot) => SimpleCard(
                  title: "History",
                  child: PerformancesList(
                    performances: snapshot.data ?? [],
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    elevation: 4,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
