import 'package:flutter/material.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/widgets/atoms/muscle_groups_surface.dart';
import 'package:vim/widgets/atoms/muscle_map/muscle_map.dart';

class ExerciseMuscleGroups extends StatelessWidget {
  const ExerciseMuscleGroups({
    super.key,
    required this.exercise,
  });

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: MuscleGroupsSurface(
            view: MuscleMapView.front,
            primary: [exercise.muscleGroups.primary].nonNulls,
            secondary: exercise.muscleGroups.secondary,
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          child: MuscleGroupsSurface(
            view: MuscleMapView.back,
            primary: [exercise.muscleGroups.primary].nonNulls,
            secondary: exercise.muscleGroups.secondary,
          ),
        ),
      ],
    );
  }
}
