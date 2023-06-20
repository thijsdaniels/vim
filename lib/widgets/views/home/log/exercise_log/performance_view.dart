import 'package:flutter/material.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/resistance_exercise_performance.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/models/exercise/weights_exercise_performance.dart';
import 'package:vim/services/performances_service.dart';
import 'package:vim/widgets/atoms/exercise_performance_muscle_groups.dart';
import 'package:vim/widgets/atoms/routine_performance_muscle_groups.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
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
  final String performanceId;

  const PerformanceView({
    super.key,
    required this.performanceId,
  });

  @override
  State<PerformanceView> createState() => _PerformanceViewState();
}

/// TODO: Split into a separate View class per performance type.
class _PerformanceViewState extends State<PerformanceView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Performance?>(
      stream: PerformancesService.instance.get(widget.performanceId),
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
                          } else {
                            return CreateQuickTrackPerformanceView(
                              performance: performance,
                            );
                          }
                        },
                      ),
                    );

                    if (edited != null) {
                      PerformancesService.instance.update(edited);
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
                      PerformancesService.instance.delete(performance);

                      if (mounted) {
                        Navigator.of(context).pop();
                      }
                    }
                  },
                ),
              ),
            ],
          ),
          body: StandardList(
            children: [
              SimpleCard(
                title: 'Details',
                child: FutureBuilder(
                  future: performance.calories,
                  builder: (context, snapshot) => Table(
                    defaultColumnWidth: const IntrinsicColumnWidth(),
                    children: [
                      if (performance is! ExercisePerformance &&
                          performance is! RoutinePerformance)
                        TableRow(
                          children: [
                            const SecondaryText('Name'),
                            const SizedBox(width: 32),
                            Text(performance.name),
                          ],
                        ),
                      if (performance is ExercisePerformance)
                        TableRow(
                          children: [
                            const SecondaryText('Exercise'),
                            const SizedBox(width: 32),
                            Text(performance.exercise.snapshot.name),
                          ],
                        ),
                      if (performance is RoutinePerformance)
                        TableRow(
                          children: [
                            const SecondaryText('Routine'),
                            const SizedBox(width: 32),
                            Text(performance.routine.name),
                          ],
                        ),
                      TableRow(
                        children: [
                          const SecondaryText('Calories'),
                          const SizedBox(width: 32),
                          Text('${snapshot.data?.round()} cal'),
                        ],
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
              if (performance is ResistanceExercisePerformance)
                SimpleCard(
                  title: 'Performance',
                  child: Center(
                    child: Table(
                      defaultColumnWidth: const IntrinsicColumnWidth(),
                      children: [
                        TableRow(
                          children: [
                            const SecondaryText('Duration'),
                            const SizedBox(width: 32),
                            Text('${performance.duration.inMinutes} m'),
                          ],
                        ),
                        TableRow(
                          children: [
                            const SecondaryText('Power'),
                            const SizedBox(width: 32),
                            Text('${performance.watts} watts'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              if (performance is WeightsExercisePerformance)

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
                            title: Text(
                              '${set.repetitions} x ${set.weight} kg',
                            ),
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
