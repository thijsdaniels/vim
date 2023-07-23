import 'package:flutter/material.dart';
import 'package:vim/extensions/date_time.dart';
import 'package:vim/extensions/num.dart';
import 'package:vim/extensions/sets.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/endurance_exercise_performance.dart';
import 'package:vim/models/exercise/resistance_exercise_performance.dart';
import 'package:vim/widgets/atoms/performance_icon.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:vim/widgets/views/home/log/exercise_log/performance_view.dart';

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
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.25),
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

        return FutureBuilder(
          future: Future.value(performance.calories),
          builder: (context, caloriesSnapshot) => ListSurface(
            elevation: elevation,
            icon: PerformanceIcon(performance),
            title: performance.name,
            // TODO: Try to change this into Chip widgets.
            subtitle: [
              '${caloriesSnapshot.data?.round()} cal',

              /// TODO: Display the `Equipment` name instead of the sets.
              if (performance is ResistanceExercisePerformance) ...[
                '${(performance.sets.weight / performance.sets.length).decimals(2)} kg',
                performance.sets
                    .map(
                      (set) => '${set.repetitions}',
                    )
                    .join("/"),
              ],
              if (performance is EnduranceExercisePerformance) ...[
                '${performance.watts} watts',
                '${performance.duration.inMinutes} m',
              ],
            ].join(" • "),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PerformanceView(
                    path: performance.reference!.path,
                  ),
                ),
              );
            },
            actions: SecondaryText(
              performance.timestamp.toDate().toTimeString(),
            ),
          ),
        );
      },
    );
  }
}
