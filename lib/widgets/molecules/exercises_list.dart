import 'package:flutter/material.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/widgets/atoms/exercise_icon.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:vim/views/home/exercise/exercises/exercise_view.dart';

class ExercisesList extends StatelessWidget {
  const ExercisesList(this.exercises, {super.key});

  final List<Exercise> exercises;

  @override
  Widget build(BuildContext context) {
    return StandardList(
      spacing: 12,
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        Exercise exercise = exercises[index];

        return StreamBuilder(
          stream: exercise.equipment,
          builder: (context, equipment) {
            return ListSurface(
              icon: ExerciseIcon(exercise),
              title: exercise.name,
              subtitle: equipment.data?.name,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        ExerciseView(id: exercise.reference!.id),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
