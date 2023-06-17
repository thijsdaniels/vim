import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/muscle_map/muscle_map.dart';

abstract class MuscleMapPainter extends CustomPainter {
  final Map<MuscleGroup, double> muscles;
  final Paint silhouettePaint = Paint()
    ..style = PaintingStyle.fill
    ..color = Colors.white.withOpacity(0.33)
    ..blendMode = BlendMode.overlay;
  late final Color inactiveColor;
  late final Color activeColor;

  MuscleMapPainter({
    this.muscles = const {},
    Color? inactiveColor,
    Color? activeColor,
  }) {
    this.inactiveColor = (inactiveColor ?? Colors.white).withOpacity(0.2);
    this.activeColor = (inactiveColor ?? Colors.white).withOpacity(0.85);
  }

  Paint getMusclePaint(MuscleGroup muscleGroup) {
    return Paint()
      ..style = PaintingStyle.fill
      ..color =
          Color.lerp(inactiveColor, activeColor, muscles[muscleGroup] ?? 0)!;
  }

  @override
  bool shouldRepaint(covariant MuscleMapPainter oldDelegate) {
    return muscles != oldDelegate.muscles ||
        inactiveColor != oldDelegate.inactiveColor ||
        activeColor != oldDelegate.activeColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    paintSilhouette(canvas, size, silhouettePaint);
    paintMuscleGroups(canvas, size);
  }

  void paintSilhouette(Canvas canvas, Size size, Paint paint);

  void paintMuscleGroups(Canvas canvas, Size size) {
    paintNeck(canvas, size, getMusclePaint(MuscleGroup.neck));
    paintTraps(canvas, size, getMusclePaint(MuscleGroup.traps));
    paintShoulders(canvas, size, getMusclePaint(MuscleGroup.shoulders));
    paintChest(canvas, size, getMusclePaint(MuscleGroup.chest));
    paintLats(canvas, size, getMusclePaint(MuscleGroup.lats));
    paintBiceps(canvas, size, getMusclePaint(MuscleGroup.biceps));
    paintTripceps(canvas, size, getMusclePaint(MuscleGroup.triceps));
    paintForearms(canvas, size, getMusclePaint(MuscleGroup.forearms));
    paintAbs(canvas, size, getMusclePaint(MuscleGroup.abs));
    paintObliques(canvas, size, getMusclePaint(MuscleGroup.obliques));
    paintLowerBack(canvas, size, getMusclePaint(MuscleGroup.lowerBack));
    paintGlutes(canvas, size, getMusclePaint(MuscleGroup.glutes));
    paintAbductors(canvas, size, getMusclePaint(MuscleGroup.abductors));
    paintAdductors(canvas, size, getMusclePaint(MuscleGroup.adductors));
    paintQuads(canvas, size, getMusclePaint(MuscleGroup.quads));
    paintHamstrings(canvas, size, getMusclePaint(MuscleGroup.hamstrings));
    paintCalves(canvas, size, getMusclePaint(MuscleGroup.calves));
  }

  void paintNeck(Canvas canvas, Size size, Paint paint) {}
  void paintTraps(Canvas canvas, Size size, Paint paint) {}
  void paintShoulders(Canvas canvas, Size size, Paint paint) {}
  void paintChest(Canvas canvas, Size size, Paint paint) {}
  void paintLats(Canvas canvas, Size size, Paint paint) {}
  void paintBiceps(Canvas canvas, Size size, Paint paint) {}
  void paintTripceps(Canvas canvas, Size size, Paint paint) {}
  void paintForearms(Canvas canvas, Size size, Paint paint) {}
  void paintAbs(Canvas canvas, Size size, Paint paint) {}
  void paintObliques(Canvas canvas, Size size, Paint paint) {}
  void paintLowerBack(Canvas canvas, Size size, Paint paint) {}
  void paintGlutes(Canvas canvas, Size size, Paint paint) {}
  void paintAbductors(Canvas canvas, Size size, Paint paint) {}
  void paintAdductors(Canvas canvas, Size size, Paint paint) {}
  void paintQuads(Canvas canvas, Size size, Paint paint) {}
  void paintHamstrings(Canvas canvas, Size size, Paint paint) {}
  void paintCalves(Canvas canvas, Size size, Paint paint) {}
}
