import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/widgets/atoms/muscle_groups_icon.dart';

class RoutineIcon extends StatelessWidget {
  final double elevation;
  final Routine routine;

  const RoutineIcon({
    super.key,
    this.elevation = 0,
    required this.routine,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: routine.exercises,
      builder: (context, snapshot) {
        return MuscleGroupsIcon(
          elevation: elevation,
          primary: snapshot.data
                  ?.map((exercise) => exercise.muscleGroups.primary)
                  .nonNulls ??
              [],
          secondary: snapshot.data
                  ?.map((exercise) => exercise.muscleGroups.secondary)
                  .flattened
                  .nonNulls ??
              [],
        );
      },
    );
  }
}
