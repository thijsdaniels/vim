import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/widgets/atoms/muscle_groups_surface.dart';
import 'package:vim/widgets/atoms/muscle_map/muscle_map.dart';

class RoutinePerformanceMuscleGroups extends StatelessWidget {
  const RoutinePerformanceMuscleGroups({
    super.key,
    required this.performance,
  });

  final RoutinePerformance performance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: performance.performances,
      builder: (context, snapshot) {
        var primary = snapshot.data
                ?.map((performance) =>
                    performance.exercise.snapshot.muscleGroups.primary)
                .nonNulls ??
            [];
        var secondary = snapshot.data
                ?.map((performance) =>
                    performance.exercise.snapshot.muscleGroups.secondary)
                .flattened
                .nonNulls ??
            [];

        return Row(
          children: [
            Flexible(
              child: MuscleGroupsSurface(
                view: MuscleMapView.front,
                primary: primary,
                secondary: secondary,
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: MuscleGroupsSurface(
                view: MuscleMapView.back,
                primary: primary,
                secondary: secondary,
              ),
            ),
          ],
        );
      },
    );
  }
}
