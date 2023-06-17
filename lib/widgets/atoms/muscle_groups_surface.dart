import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/muscle_groups.dart';
import 'package:vim/widgets/atoms/muscle_map/muscle_map.dart';
import 'package:vim/widgets/atoms/surface.dart';

class MuscleGroupsSurface extends StatelessWidget {
  final EdgeInsets padding;
  final MuscleMapView view;
  final Iterable<MuscleGroup> primary;
  final Iterable<MuscleGroup> secondary;

  const MuscleGroupsSurface({
    super.key,
    this.padding = const EdgeInsets.all(16.0),
    required this.view,
    this.primary = const [],
    this.secondary = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Surface(
      isPrimary: true,
      child: Padding(
        padding: padding,
        child: MuscleGroups(
          view: view,
          primary: primary,
          secondary: secondary,
        ),
      ),
    );
  }
}
