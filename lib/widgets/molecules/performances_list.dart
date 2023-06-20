import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vim/extensions/num.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/resistance_exercise_performance.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/models/exercise/weights_exercise_performance.dart';
import 'package:vim/widgets/atoms/exercise_performance_icon.dart';
import 'package:vim/widgets/atoms/routine_performance_icon.dart';
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
      itemCount: performances.length,
      itemBuilder: (context, index) {
        Performance performance = performances[index];

        return ListSurface(
          elevation: elevation,
          icon: getIcon(performance),
          title: Text(performance.name, overflow: TextOverflow.ellipsis),
          subtitle: FutureBuilder(
            future: performance.calories,
            builder: (context, snapshot) => SecondaryText(
              // TODO: Try to change this into Chip widgets.
              [
                '${snapshot.data?.round()} cal',
                if (performance is WeightsExercisePerformance) ...[
                  '${(performance.sets.weight / performance.sets.length).decimals(2)} kg',
                  performance.sets
                      .map(
                        (set) => '${set.repetitions}',
                      )
                      .join("/"),
                ],
                if (performance is ResistanceExercisePerformance) ...[
                  '${performance.watts} watts',
                  '${performance.duration.inMinutes} m',
                ],
              ].join(" • "),
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PerformanceView(
                  performanceId: performance.reference!.id,
                ),
              ),
            );
          },
          actions: SecondaryText(
            DateFormat.Hm('en_US').format(performance.timestamp.toDate()),
          ),
          // trailing: Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     IconButton(
          //       icon: const Icon(Icons.edit),
          //       onPressed: () async {
          //         Performance editedPerformance =
          //             await Navigator.of(context).push(
          //           MaterialPageRoute(builder: (context) {
          //             if (performance is ExercisePerformance) {
          //               return CreateExercisePerformanceView(
          //                 exercisePerformance: performance,
          //               );
          //             } else if (performance is RoutinePerformance) {
          //               return CreateRoutinePerformanceView(
          //                 routinePerformance: performance,
          //               );
          //             } else {
          //               return CreatePerformanceView(
          //                 performance: performance,
          //               );
          //             }
          //           }),
          //         );

          //         PerformancesService.update(editedPerformance);
          //       },
          //     ),
          //     WithConfirmationDialog(
          //       title: performance.name,
          //       description:
          //           'Are you sure you want to delete this performance?',
          //       builder: (context, confirm) => IconButton(
          //         icon: const Icon(Icons.delete),
          //         onPressed: () async {
          //           if (await confirm()) {
          //             PerformancesService.delete(performance);
          //           }
          //         },
          //       ),
          //     ),
          //   ],
          // ),
        );
      },
    );
  }

  Widget? getIcon(Performance performance) {
    if (performance is RoutinePerformance) {
      return RoutinePerformanceIcon(
        performance: performance,
      );
    } else if (performance is ExercisePerformance) {
      return ExercisePerformanceIcon(
        performance: performance,
      );
    }

    return null;
  }
}
