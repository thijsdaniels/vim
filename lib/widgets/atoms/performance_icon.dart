import 'package:flutter/material.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/widgets/atoms/exercise_performance_icon.dart';
import 'package:vim/widgets/atoms/routine_performance_icon.dart';

class PerformanceIcon extends StatelessWidget {
  final double elevation;
  final Performance performance;

  const PerformanceIcon(
    this.performance, {
    super.key,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    if (performance is ExercisePerformance) {
      return ExercisePerformanceIcon(performance as ExercisePerformance);
    } else if (performance is RoutinePerformance) {
      return RoutinePerformanceIcon(performance as RoutinePerformance);
    } else {
      return Container();
    }
  }
}
