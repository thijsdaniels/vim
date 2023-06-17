import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/muscle_groups.dart';
import 'package:vim/widgets/atoms/muscle_map/muscle_map.dart';
import 'package:vim/widgets/atoms/surface.dart';

class MuscleGroupsIcon extends StatelessWidget {
  final double? elevation;
  final Iterable<MuscleGroup> primary;
  final Iterable<MuscleGroup> secondary;

  const MuscleGroupsIcon({
    super.key,
    this.elevation,
    this.primary = const [],
    this.secondary = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Surface(
      isPrimary: true,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: OverflowBox(
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          alignment: const Alignment(0, -0.40),
          child: FittedBox(
            fit: BoxFit.cover,
            alignment: Alignment.center,
            child: SizedBox(
              width: 64,
              height: 128,
              child: MuscleGroups(
                view: MuscleMapView.front,
                primary: primary,
                secondary: secondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
