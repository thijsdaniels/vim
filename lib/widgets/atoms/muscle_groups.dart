import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/muscle_map/muscle_map.dart';

class MuscleGroups extends StatelessWidget {
  final MuscleMapView view;
  final Iterable<MuscleGroup> primary;
  final Iterable<MuscleGroup> secondary;

  const MuscleGroups({
    super.key,
    required this.view,
    this.primary = const [],
    this.secondary = const [],
  });

  @override
  Widget build(BuildContext context) {
    return MuscleMap(
      view: view,
      muscles: {
        ...Map.fromEntries(
          secondary.map(
            (muscleGroup) => MapEntry(muscleGroup, 0.5),
          ),
        ),
        ...Map.fromEntries(
          primary.map(
            (muscleGroup) => MapEntry(muscleGroup, 1),
          ),
        ),
      },
    );
  }
}
