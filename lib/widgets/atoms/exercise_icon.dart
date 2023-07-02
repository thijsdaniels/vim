import 'package:flutter/material.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/widgets/atoms/muscle_groups_focus_icon.dart';

class ExerciseIcon extends StatelessWidget {
  const ExerciseIcon(
    this.exercise, {
    super.key,
    this.elevation = 4,
  });

  final Exercise? exercise;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return MuscleGroupsFocusIcon(
      elevation: elevation,
      primary: exercise?.muscleGroups.primary,
      secondary: exercise?.muscleGroups.secondary ?? [],
    );
  }
}
