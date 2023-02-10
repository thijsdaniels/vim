import 'package:flutter/material.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/services/performances_service.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';
import 'package:vim/widgets/views/home/log/create_exercise_performance_view.dart';
import 'package:vim/widgets/views/home/log/create_performance_view.dart';
import 'package:vim/widgets/views/home/log/create_routine_performance_view.dart';

class PerformanceView extends StatefulWidget {
  final Performance performance;

  const PerformanceView({
    super.key,
    required this.performance,
  });

  @override
  State<PerformanceView> createState() => _PerformanceViewState();
}

class _PerformanceViewState extends State<PerformanceView> {
  @override
  Widget build(BuildContext context) {
    Performance performance = widget.performance;

    return Scaffold(
      appBar: AppBar(
        title: Text(performance.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              if (performance is RoutinePerformance) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateRoutinePerformanceView(
                      routinePerformance: performance,
                    ),
                  ),
                );
              } else if (performance is ExercisePerformance) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateExercisePerformanceView(
                      exercisePerformance: performance,
                    ),
                  ),
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreatePerformanceView(
                      performance: performance,
                    ),
                  ),
                );
              }
            },
          ),
          WithConfirmationDialog(
            title: performance.name,
            description: 'Are you sure you want to delete this performance?',
            builder: (context, confirm) => IconButton(
              icon: const Icon(Icons.delete_rounded),
              onPressed: () async {
                if (await confirm()) {
                  PerformancesService.delete(performance);

                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SimpleCard(
                title: 'Details',
                child: Center(
                  child: Table(
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
                      if (performance is ExercisePerformance) ...[
                        TableRow(
                          children: [
                            const SecondaryText('Exercise'),
                            const SizedBox(width: 32),
                            Text(performance.exercise.name),
                          ],
                        ),
                      ],
                      if (performance is RoutinePerformance) ...[
                        TableRow(
                          children: [
                            const SecondaryText('Routine'),
                            const SizedBox(width: 32),
                            Text(performance.routine.name),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              if (performance is RoutinePerformance)
                SimpleCard(
                  title: 'Exercises',
                  child: Center(
                    child: Table(
                      defaultColumnWidth: const IntrinsicColumnWidth(),
                      children: performance.routine.plan
                          .map(
                            (performance) => TableRow(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(performance.exercise?.name ??
                                        'Missing'), // TODO Make sure the exercise _can't_ be missing.
                                  ],
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
