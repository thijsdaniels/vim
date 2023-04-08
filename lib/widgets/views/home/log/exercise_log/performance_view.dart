import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/resistance_exercise_performance.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/models/exercise/weights_exercise_performance.dart';
import 'package:vim/services/performances_service.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/molecules/routine_exercise_performances.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';
import 'package:vim/widgets/views/home/log/exercise_log/create_exercise_performance_view.dart';
import 'package:vim/widgets/views/home/log/exercise_log/create_quick_track_performance_view.dart';
import 'package:vim/widgets/views/home/log/exercise_log/create_routine_performance_view.dart';

class PerformanceView extends StatefulWidget {
  final String performanceId;

  const PerformanceView({
    super.key,
    required this.performanceId,
  });

  @override
  State<PerformanceView> createState() => _PerformanceViewState();
}

class _PerformanceViewState extends State<PerformanceView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Performance?>(
        stream: PerformancesService.instance.get(widget.performanceId),
        builder: (context, snapshot) {
          Performance? performance = snapshot.data;

          return Scaffold(
            appBar: AppBar(
              title: Text(performance?.name ?? ''),
              actions: [
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
                if (performance != null)
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
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    if (performance != null)
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
                              if (performance is ExercisePerformance)
                                TableRow(
                                  children: [
                                    const SecondaryText('Exercise'),
                                    const SizedBox(width: 32),
                                    Text(performance.exercise.name),
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
                                  Text('${performance.calories.round()} cal'),
                                ],
                              ),
                            ],
                          ),
                        ),
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
                      SimpleCard(
                        title: 'Performance',
                        child: Column(
                          children: performance.sets
                              .map(
                                (set) => Card(
                                  elevation: 4,
                                  child: ListTile(
                                    title: Text(
                                      '${set.repetitions} x ${set.weight} kg',
                                    ),
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
              ),
            ),
          );
        });
  }
}
