import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/extensions/string.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/widgets/atoms/floating_action_surface.dart';
import 'package:vim/widgets/atoms/muscle_groups_focus_icon.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:vim/widgets/views/home/exercise/exercises/create_exercise_view.dart';
import 'package:vim/widgets/views/home/exercise/exercises/exercise_view.dart';

class ExercisesView extends StatelessWidget {
  const ExercisesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionSurface(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CreateExerciseView(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<List<Exercise>>(
          builder: (context, exercises, child) => StandardList(
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              Exercise exercise = exercises[index];

              return ListSurface(
                icon: MuscleGroupsFocusIcon(
                  elevation: 4,
                  primary: exercise.muscleGroups.primary,
                  secondary: exercise.muscleGroups.secondary,
                ),
                title: exercise.name,
                subtitle: exercise.type.name.toTitleCase(),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ExerciseView(exercise.reference!.id),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
