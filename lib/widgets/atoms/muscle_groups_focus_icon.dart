import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/muscle_map/muscle_map.dart';
import 'package:vim/widgets/atoms/surface.dart';

class MuscleGroupsFocusIcon extends StatelessWidget {
  final double? elevation;
  final MuscleMapView? view;
  final MuscleGroup? primary;
  final List<MuscleGroup> secondary;

  const MuscleGroupsFocusIcon({
    super.key,
    this.elevation,
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
      elevation: elevation,
      isPrimary: true,
      child: OverflowBox(
        maxWidth: double.infinity,
        maxHeight: double.infinity,
        alignment: offset,
        child: FittedBox(
          fit: BoxFit.cover,
          alignment: Alignment.center,
          child: SizedBox(
            width: 100,
            height: 200,
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
              // activeColor: Theme.of(context).colorScheme.primary,
              // inactiveColor:
              //     Theme.of(context).colorScheme.primary.withOpacity(0.15),
            ),
          ),
        ),
      ),
    );
  }

  Alignment get offset {
    switch (primary) {
      case MuscleGroup.neck:
        return const Alignment(0, -0.95);
      case MuscleGroup.traps:
        return const Alignment(0, -0.94);
      case MuscleGroup.shoulders:
        return const Alignment(0, -0.92);
      case MuscleGroup.chest:
        return const Alignment(0, -0.90);
      case MuscleGroup.lats:
        return const Alignment(0, -0.71);
      case MuscleGroup.triceps:
        return const Alignment(0, -0.69);
      case MuscleGroup.biceps:
        return const Alignment(0, -0.68);
      case MuscleGroup.abs:
        return const Alignment(0, -0.44);
      case MuscleGroup.forearms:
        return const Alignment(2.35, -0.40);
      case MuscleGroup.obliques:
        return const Alignment(0, -0.40);
      case MuscleGroup.lowerBack:
        return const Alignment(0, -0.36);
      case MuscleGroup.glutes:
        return const Alignment(0, -0.10);
      case MuscleGroup.abductors:
        return const Alignment(0, -0.09);
      case MuscleGroup.adductors:
        return const Alignment(0, 0.06);
      case MuscleGroup.quads:
        return const Alignment(0, 0.17);
      case MuscleGroup.hamstrings:
        return const Alignment(0, 0.32);
      case MuscleGroup.calves:
        return const Alignment(0, 0.97);
      default:
        return const Alignment(0, -0.55);
    }
  }
}
