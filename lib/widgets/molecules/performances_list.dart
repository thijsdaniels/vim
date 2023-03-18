import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/performances.dart';
import 'package:vim/models/exercise/resistance_exercise_performance.dart';
import 'package:vim/models/exercise/weights_exercise_performance.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
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
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Icon(
              Icons.more_horiz,
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.25),
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: performances.length,
      itemBuilder: (context, index) {
        Performance performance = performances.get(index);

        return Card(
          child: ListTile(
            title: Text(performance.name),
            subtitle: SecondaryText(
              // TODO: Try to change this into Chip widgets.
              [
                '${performance.calories.round()} cal',
                if (performance is WeightsExercisePerformance) ...[
                  '${(performance.sets.weight / performance.sets.length)} kg',
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
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      PerformanceView(performance: performance),
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
          ),
        );
      },
    );
  }
}
