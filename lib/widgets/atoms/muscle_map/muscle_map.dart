import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/muscle_map/muscle_map_back_painter.dart';
import 'package:vim/widgets/atoms/muscle_map/muscle_map_front_painter.dart';

enum MuscleMapView {
  front,
  back,
}

enum MuscleGroup {
  neck,
  traps,
  shoulders,
  chest,
  lats,
  biceps,
  triceps,
  abs,
  forearms,
  obliques,
  lowerBack,
  glutes,
  abductors,
  adductors,
  quads,
  hamstrings,
  calves,
}

class MuscleMap extends StatelessWidget {
  final MuscleMapView view;
  final Map<MuscleGroup, double> muscles;

  const MuscleMap({
    super.key,
    required this.view,
    this.muscles = const {},
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 2,
      child: () {
        switch (view) {
          case MuscleMapView.front:
            return CustomPaint(
              painter: MuscleMapFrontPainter(
                muscles: muscles,
              ),
              size: const Size(200, 400),
            );
          case MuscleMapView.back:
            return CustomPaint(
              painter: MuscleMapBackPainter(
                muscles: muscles,
              ),
              size: const Size(200, 400),
            );
        }
      }(),
    );
  }
}
