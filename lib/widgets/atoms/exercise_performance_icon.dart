import 'package:flutter/material.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/widgets/atoms/muscle_groups_focus_icon.dart';

class ExercisePerformanceIcon extends StatelessWidget {
  final ExercisePerformance performance;

  const ExercisePerformanceIcon(
    this.performance, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MuscleGroupsFocusIcon(
      elevation: 4,
      primary: performance.exercise.snapshot.muscleGroups.primary,
      secondary: performance.exercise.snapshot.muscleGroups.secondary,
    );
  }
}
