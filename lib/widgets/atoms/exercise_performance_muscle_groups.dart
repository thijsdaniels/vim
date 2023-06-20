import 'package:flutter/material.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/widgets/atoms/muscle_groups_surface.dart';
import 'package:vim/widgets/atoms/muscle_map/muscle_map.dart';

class ExercisePerformanceMuscleGroups extends StatelessWidget {
  const ExercisePerformanceMuscleGroups({
    super.key,
    required this.performance,
  });

  final ExercisePerformance performance;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: MuscleGroupsSurface(
            view: MuscleMapView.front,
            primary:
                [performance.exercise.snapshot.muscleGroups.primary].nonNulls,
            secondary: performance.exercise.snapshot.muscleGroups.secondary,
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: MuscleGroupsSurface(
            view: MuscleMapView.back,
            primary:
                [performance.exercise.snapshot.muscleGroups.primary].nonNulls,
            secondary: performance.exercise.snapshot.muscleGroups.secondary,
          ),
        ),
      ],
    );
  }
}
