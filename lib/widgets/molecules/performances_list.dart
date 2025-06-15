import 'package:flutter/material.dart';
import 'package:vim/extensions/date_time.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/views/log/exercise_log/performance_view.dart';
import 'package:vim/widgets/atoms/performance_icon.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/list_surface.dart';

class PerformancesList extends StatelessWidget {
  const PerformancesList({
    super.key,
    required this.performances,
    this.physics,
    this.padding = const EdgeInsets.all(16.0),
    this.elevation = 1,
  });

  final List<Performance> performances;
  final ScrollPhysics? physics;
  final EdgeInsets padding;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    if (performances.isEmpty) {
      return Center(
        child: Icon(
          Icons.more_horiz,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.25),
        ),
      );
    }

    return StandardList(
      physics: physics,
      padding: padding,
      spacing: 12,
      itemCount: performances.length,
      itemBuilder: (context, index) {
        Performance performance = performances[index];

        if (performance is ExercisePerformance) {
          return ExercisePerformanceListSurface(
            performance,
            elevation: elevation,
          );
        }

        return PerformanceListSurface(
          performance,
          elevation: elevation,
        );
      },
    );
  }
}

class PerformanceListSurface extends StatelessWidget {
  const PerformanceListSurface(
    this.performance, {
    super.key,
    this.elevation,
    this.subtitle,
  });

  final Performance performance;
  final double? elevation;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return ListSurface(
      elevation: elevation,
      icon: PerformanceIcon(performance),
      title: performance.name,
      subtitle: subtitle,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PerformanceView(
              path: performance.reference!.path,
            ),
          ),
        );
      },
      trailing: SecondaryText(
        performance.timestamp.toDate().toTimeString(),
      ),
    );
  }
}

class ExercisePerformanceListSurface extends StatelessWidget {
  const ExercisePerformanceListSurface(
    this.performance, {
    super.key,
    this.elevation,
  });

  final ExercisePerformance performance;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: performance.exercise.snapshot.equipment,
      builder: (context, equipment) => PerformanceListSurface(
        performance,
        subtitle: equipment.data?.name,
      ),
    );
  }
}
