import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/extensions/num.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/performances.dart';
import 'package:vim/models/exercise/resistance_exercise_performance.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/models/exercise/weights_exercise_performance.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:vim/widgets/views/home/log/exercise_log/performance_view.dart';

// TODO: Receive `performances` as a parameter instead of taking them from
// context, so that this widget can also be used with a particular set of
// performances other than the main one.
class PerformancesList extends StatelessWidget {
  const PerformancesList({super.key});

  @override
  Widget build(BuildContext context) {
    Performances performances = Provider.of<Performances>(context);

    if (performances.length == 0) {
      return Center(
        child: Icon(
          Icons.more_horiz,
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.25),
        ),
      );
    }

    return StandardList(
      itemCount: performances.length,
      itemBuilder: (context, index) {
        Performance performance = performances.get(index);

        return ListSurface(
          icon: getIcon(performance),
          title: Text(performance.name),
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
      return Icons8Icon.asset('greek-helmet', size: 48);
    } else if (performance is WeightsExercisePerformance) {
      return Icons8Icon.network('dumbbell', size: 48);
    } else if (performance is ResistanceExercisePerformance) {
      return Icons8Icon.network('trainers', size: 48);
    }

    return null;
  }
}
