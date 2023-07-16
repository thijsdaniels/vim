import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/widgets/atoms/muscle_groups_icon.dart';

class RoutinePerformanceIcon extends StatelessWidget {
  final double elevation;
  final RoutinePerformance performance;

  const RoutinePerformanceIcon(
    this.performance, {
    super.key,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: performance.performances,
      builder: (context, snapshot) {
        return MuscleGroupsIcon(
          elevation: elevation,
          primary: snapshot.data
                  ?.map((performance) =>
                      performance.exercise.snapshot.muscleGroups.primary)
                  .nonNulls ??
              [],
          secondary: snapshot.data
                  ?.map((performance) =>
                      performance.exercise.snapshot.muscleGroups.secondary)
                  .flattened
                  .nonNulls ??
              [],
        );
      },
    );
  }
}
