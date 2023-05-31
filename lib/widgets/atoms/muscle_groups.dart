import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/muscle_map/muscle_map.dart';
import 'package:vim/widgets/atoms/surface.dart';

class MuscleGroups extends StatelessWidget {
  final MuscleMapView? view;
  final MuscleGroup? primary;
  final List<MuscleGroup> secondary;

  const MuscleGroups({
    super.key,
    this.view,
    this.primary,
    this.secondary = const [],
  });

  MuscleMapView get _view {
    return view ??
        ([
          MuscleGroup.traps,
          MuscleGroup.lats,
          MuscleGroup.triceps,
          MuscleGroup.lowerBack,
          MuscleGroup.glutes,
          MuscleGroup.hamstrings,
          MuscleGroup.calves,
        ].contains(primary)
            ? MuscleMapView.back
            : MuscleMapView.front);
  }

  @override
  Widget build(BuildContext context) {
    return Surface(
      primary: true,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MuscleMap(
          view: _view,
          muscles: {
            ...Map.fromEntries(
              secondary.map(
                (muscleGroup) => MapEntry(muscleGroup, 0.5),
              ),
            ),
            if (primary != null) primary!: 1,
          },
        ),
      ),
    );
  }
}
