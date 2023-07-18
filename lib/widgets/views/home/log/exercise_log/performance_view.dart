import 'package:flutter/material.dart';
import 'package:vim/extensions/date_time.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/quick_performance.dart';
import 'package:vim/models/exercise/endurance_exercise_performance.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/models/exercise/resistance_exercise_performance.dart';
import 'package:vim/services/performances_collection_group.dart';
import 'package:vim/services/performances_collection.dart';
import 'package:vim/widgets/atoms/exercise_performance_muscle_groups.dart';
import 'package:vim/widgets/atoms/routine_performance_muscle_groups.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/atoms/stats_table.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:vim/widgets/molecules/routine_exercise_performances.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';
import 'package:vim/widgets/views/home/log/exercise_log/create_exercise_performance_view.dart';
import 'package:vim/widgets/views/home/log/exercise_log/create_quick_track_performance_view.dart';
import 'package:vim/widgets/views/home/log/exercise_log/create_routine_performance_view.dart';
import 'package:vim/widgets/views/loading_view.dart';
import 'package:vim/widgets/views/not_found_view.dart';

class PerformanceView extends StatefulWidget {
  final String path;

  const PerformanceView({
    super.key,
    required this.path,
  });

  @override
  State<PerformanceView> createState() => _PerformanceViewState();
}

/// TODO: Split into a separate View class per performance type.
class _PerformanceViewState extends State<PerformanceView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Performance?>(
      stream: PerformancesCollectionGroup.instance.get(widget.path),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingView();
        }

        if (!snapshot.hasData) {
          return const NotFoundView();
        }

        Performance performance = snapshot.requireData!;

        return Scaffold(
          appBar: AppBar(
            title: Text(performance.name),
            actions: [
              if (performance is! RoutinePerformance)
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    Performance? edited = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          if (performance is RoutinePerformance) {
                            return CreateRoutinePerformanceView(
                              routinePerformance: performance,
                            );
                          } else if (performance is ExercisePerformance) {
                            return CreateExercisePerformanceView(
                              exercisePerformance: performance,
                            );
                          } else if (performance is QuickPerformance) {
                            return CreateQuickTrackPerformanceView(
                              performance: performance,
                            );
                          } else {
                            throw Exception("Unsupported performance type");
                          }
                        },
                      ),
                    );

                    if (edited != null) {
                      PerformancesCollection.of(context).update(edited);
                    }
                  },
                ),
              WithConfirmationDialog(
                title: performance.name,
                description:
                    'Are you sure you want to delete this performance?',
                builder: (context, confirm) => IconButton(
                  icon: const Icon(Icons.delete_rounded),
                  onPressed: () async {
                    if (await confirm()) {
                      PerformancesCollection.of(context).delete(performance);

                      if (mounted) {
                        Navigator.of(context).pop();
                      }
                    }
                  },
                ),
              ),
            ],
          ),

          /// TODO: Split this body into three separate widgets, one for each of
          /// the types of performance. All these `if` statements I'm using are
          /// making this body very difficult to read.
          body: StandardList(
            children: [
              SimpleCard(
                title: 'Details',
                child: FutureBuilder(
                  future: Future.value(performance.calories),
                  builder: (context, snapshot) => StatsTable(
                    children: [
                      if (performance is QuickPerformance)
                        StatsRow(
                          'Name',
                          performance.name,
                        ),
                      if (performance is ExercisePerformance)
                        StatsRow(
                          'Exercise',
                          performance.exercise.snapshot.name,
                        ),
                      if (performance is RoutinePerformance)
                        StatsRow(
                          'Routine',
                          performance.routine.snapshot.name,
                        ),
                      StatsRow(
                        'Calories',
                        '${snapshot.data?.round()} cal',
                      ),
                      StatsRow(
                        'Performed At',
                        performance.timestamp.toDate().toDateTimeString(),
                      ),
                    ],
                  ),
                ),
              ),
              if (performance is RoutinePerformance)
                RoutinePerformanceMuscleGroups(
                  performance: performance,
                ),
              if (performance is ExercisePerformance)
                ExercisePerformanceMuscleGroups(
                  performance: performance,
                ),
              if (performance is EnduranceExercisePerformance)
                SimpleCard(
                  title: 'Performance',
                  child: StatsTable(
                    children: [
                      StatsRow(
                        'Duration',
                        '${performance.duration.inMinutes}',
                        unit: 'm',
                      ),
                      StatsRow(
                        'Power',
                        '${performance.watts}',
                        unit: 'watts',
                      ),
                    ],
                  ),
                ),
              if (performance is ResistanceExercisePerformance)

                /// TODO: Add, edit and remove sets here instead of having to
                /// navigate to an edit view.
                SimpleCard(
                  title: 'Sets',
                  child: StandardList(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: performance.sets
                        .map(
                          (set) => ListSurface(
                            elevation: 4,
                            title: '${set.repetitions} x ${set.weight} kg',
                          ),
                        )
                        .toList(),
                  ),
                ),
              if (performance is RoutinePerformance)
                SimpleCard(
                  title: 'Performances',
                  child: RoutineExercisePerformances(
                    routinePerformance: performance,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
