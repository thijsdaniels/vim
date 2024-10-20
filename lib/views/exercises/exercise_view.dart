import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:vim/extensions/sets.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/resistance_exercise_performance.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/exercises_collection.dart';
import 'package:vim/services/exercises_collection_group.dart';
import 'package:vim/services/performances_collection_group.dart';
import 'package:vim/views/exercises/create_exercise_view.dart';
import 'package:vim/views/loading_view.dart';
import 'package:vim/views/not_found_view.dart';
import 'package:vim/widgets/atoms/exercise_muscle_groups.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/atoms/stats_table.dart';
import 'package:vim/widgets/molecules/line_chart.dart';
import 'package:vim/widgets/molecules/performances_list.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';

class ExerciseView extends StatelessWidget {
  final String path;

  const ExerciseView({
    super.key,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Exercise?>(
      stream: ExercisesCollectionGroup.instance.get(path),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingView();
        }

        if (!snapshot.hasData) {
          return const NotFoundView();
        }

        Exercise exercise = snapshot.requireData!;

        return Scaffold(
          appBar: AppBar(
            title: Text(exercise.name),
            actions: [
              if (exercise.reference!.parent.parent!.id ==
                  User.of(context).reference!.id) ...[
                IconButton(
                  icon: const Icon(Icons.edit_rounded),
                  onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CreateExerciseView(
                          exercise: exercise,
                        ),
                      ),
                    );
                  },
                ),
                WithConfirmationDialog(
                  title: exercise.name,
                  description: 'Are you sure you want to delete this exercise?',
                  builder: (context, confirm) => IconButton(
                    icon: const Icon(Icons.delete_rounded),
                    onPressed: () async {
                      var navigator = Navigator.of(context);
                      if (await confirm()) {
                        ExercisesCollection.of(context).delete(exercise);
                        navigator.pop();
                      }
                    },
                  ),
                ),
              ],
            ],
          ),
          body: StreamBuilder(
            stream: PerformancesCollectionGroup.instance.forExercise(
              exercise,
              user: User.of(context),
            ),
            builder: (context, performances) => StandardList(
              children: [
                SimpleCard(
                  title: 'Details',
                  child: StreamBuilder(
                    stream: exercise.equipment,
                    builder: (context, equipment) {
                      return StatsTable(
                        children: [
                          StatsRow('Name', exercise.name),
                          StatsRow(
                              'Type',

                              /// TODO: Use `exercise.type.name.toTitleCase()`
                              /// when the `ExerciseType` values have been
                              /// renamed.
                              switch (exercise.type) {
                                ExerciseType.manual => 'Manual',
                                ExerciseType.resistance => 'Endurance',
                                ExerciseType.weights => 'Resistance',
                              }),
                        ],
                      );
                    },
                  ),
                ),
                SimpleCard(
                  title: 'Method',
                  child: StreamBuilder(
                    stream: exercise.equipment,
                    builder: (context, equipment) {
                      return StatsTable(
                        children: [
                          StatsRow('Equipment', equipment.data?.name),
                          StatsRow(
                              'Bodyweight',
                              (exercise.bodyweightFactor * 100)
                                  .round()
                                  .toString(),
                              unit: '%'),
                          StatsRow(
                            'Unilateral',
                            exercise.isUnilateral ? 'Yes' : 'No',
                          ),
                        ],
                      );
                    },
                  ),
                ),
                ExerciseMuscleGroups(exercise: exercise),
                SimpleCard(
                  title: "Trend",
                  actions: exercise.type == ExerciseType.weights
                      ? const [Text('Weight')]
                      : const [Text('Calories')],
                  child: performances.hasData
                      ? performances.data!.isNotEmpty
                          ? Builder(builder: (context) {
                              var data = Map.fromEntries(
                                performances.data!.map(
                                  (performance) => MapEntry(
                                    performance.timestamp.toDate(),
                                    performance is ResistanceExercisePerformance
                                        ? performance.sets.weight /
                                            performance.sets.length
                                        : performance.calories,
                                  ),
                                ),
                              );

                              return LineChart(
                                elevation: 4,
                                series: [data],
                                yAxis: (
                                  min: 0,
                                  max: data.isNotEmpty
                                      ? data.values.max + data.values.min
                                      : 50,
                                  interval: data.isNotEmpty
                                      ? ((data.values.max + data.values.min) /
                                              6)
                                          .ceil()
                                      : 10,
                                ),
                                xAxis: (
                                  min: DateTime.now()
                                      .subtract(const Duration(days: 90))
                                      .millisecondsSinceEpoch,
                                  max: DateTime.now()
                                      .add(const Duration(days: 1))
                                      .millisecondsSinceEpoch,
                                  interval: millisecondsPerDay * 7,
                                ),
                              );
                            })
                          : const Center(child: Text('No Data'))
                      : const CircularProgressIndicator(),
                ),
                SimpleCard(
                  title: "History",
                  child: PerformancesList(
                    performances: performances.data ?? [],
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    elevation: 4,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
