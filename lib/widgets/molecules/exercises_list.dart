import 'package:flutter/material.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/widgets/atoms/exercise_icon.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:vim/views/exercises/exercise_view.dart';

class ExercisesList extends StatelessWidget {
  const ExercisesList(
    this.exercises, {
    super.key,
    this.elevation,
    this.physics,
    this.padding = const EdgeInsets.all(16),
  });

  final List<Exercise> exercises;
  final double? elevation;
  final ScrollPhysics? physics;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return StandardList(
      spacing: 12,
      physics: physics,
      padding: padding,
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        Exercise exercise = exercises[index];

        return StreamBuilder(
          stream: exercise.equipment,
          builder: (context, equipment) {
            return ListSurface(
              elevation: elevation,
              icon: ExerciseIcon(exercise),
              title: exercise.name,
              subtitle: equipment.data?.name,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ExerciseView(
                      path: exercise.reference!.path,
                    ),
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
