import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/widgets/atoms/muscle_groups_surface.dart';
import 'package:vim/widgets/atoms/muscle_map/muscle_map.dart';

class RoutineMuscleGroups extends StatelessWidget {
  const RoutineMuscleGroups({
    super.key,
    required this.routine,
  });

  final Routine routine;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: routine.exercises,
      builder: (context, snapshot) {
        var primary = snapshot.data
                ?.map((exercise) => exercise.muscleGroups.primary)
                .nonNulls ??
            [];

        var secondary = snapshot.data
                ?.map((exercise) => exercise.muscleGroups.secondary)
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
