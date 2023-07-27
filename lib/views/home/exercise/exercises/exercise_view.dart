import 'package:flutter/material.dart';
import 'package:vim/extensions/string.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/exercises_collection.dart';
import 'package:vim/services/performances_collection_group.dart';
import 'package:vim/widgets/atoms/exercise_muscle_groups.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/atoms/stats_table.dart';
import 'package:vim/widgets/molecules/performances_list.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';
import 'package:vim/views/home/exercise/exercises/create_exercise_view.dart';
import 'package:vim/views/loading_view.dart';
import 'package:vim/views/not_found_view.dart';

class ExerciseView extends StatelessWidget {
  final String id;

  const ExerciseView({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Exercise?>(
      stream: ExercisesCollection.of(context).get(id),
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
                      ExercisesCollection.of(context).delete(exercise);
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
                child: StreamBuilder(
                  stream: exercise.equipment,
                  builder: (context, equipment) {
                    return StatsTable(
                      children: [
                        StatsRow('Name', exercise.name),
                        StatsRow('Type', exercise.type.name.toTitleCase()),
                      ],
                    );
                  },
                ),
              ),
              SimpleCard(
                title: 'Method',
                child: StreamBuilder(
                  stream: exercise.equipment,
                  builder: (context, equipment) {
                    return StatsTable(
                      children: [
                        StatsRow('Equipment', equipment.data?.name),
                        StatsRow(
                            'Bodyweight',
                            (exercise.bodyweightFactor * 100)
                                .round()
                                .toString(),
                            unit: '%'),
                        StatsRow(
                          'Unilateral',
                          exercise.isUnilateral ? 'Yes' : 'No',
                        ),
                      ],
                    );
                  },
                ),
              ),
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
              ExerciseMuscleGroups(exercise: exercise),
              StreamBuilder(
                stream: PerformancesCollectionGroup.instance.forExercise(
                  exercise,
                  user: User.of(context),
                ),
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
