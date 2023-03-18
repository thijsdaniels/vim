import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vim/models/collection.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/resistance_exercise_performance.dart';
import 'package:vim/models/exercise/set.dart';
import 'package:vim/models/exercise/sets.dart';
import 'package:vim/models/exercise/weights_exercise_performance.dart';
import 'package:vim/services/exercises_service.dart';
import 'package:vim/services/performances_service.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/views/home/log/exercise_log/create_exercise_performance_view.dart';

class ExercisePerformancesList extends StatefulWidget {
  const ExercisePerformancesList({
    super.key,
    required this.exerciseReferences,
    required this.performances,
    required this.onExercisesChanged,
    required this.onPerformancesChanged,
  });

  final List<DocumentReference> exerciseReferences;
  final Map<String, ExercisePerformance?> performances;
  final void Function(Collection<Exercise> exercises) onExercisesChanged;
  final void Function(Map<String, ExercisePerformance?> performances)
      onPerformancesChanged;

  @override
  State<ExercisePerformancesList> createState() =>
      _ExercisePerformancesListState();
}

class _ExercisePerformancesListState extends State<ExercisePerformancesList> {
  List<DocumentReference> _exerciseReferences = [];
  Map<String, ExercisePerformance?> _performances = {};

  @override
  void initState() {
    super.initState();

    _exerciseReferences = widget.exerciseReferences;
    _performances = widget.performances;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: _exerciseReferences.asMap().entries.map(
        (entry) {
          String id = entry.value.id;
          ExercisePerformance? performance =
              _performances[entry.key.toString()];

          return StreamBuilder<Exercise?>(
            stream: ExercisesService.instance.get(id),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Text('loading...');
              }

              Exercise exercise = snapshot.data!;

              return StreamBuilder<Performance>(
                stream: PerformancesService.latest(
                  name: exercise.name,
                ),
                builder: (context, snapshot) {
                  ExercisePerformance? latest =
                      snapshot.data as ExercisePerformance?;

                  return Card(
                    key: Key(exercise.reference!.id),
                    elevation: 4,
                    child: ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: performance != null,
                            onChanged: (value) {
                              if (value!) {
                                ExercisePerformance performance;

                                switch (exercise.type) {
                                  case ExerciseType.manual:
                                    performance = ExercisePerformance(
                                      timestamp: Timestamp.now(),
                                      exercise: exercise,
                                      calories: latest?.calories ?? 0,
                                    );
                                    break;
                                  case ExerciseType.resistance:
                                    performance = ResistanceExercisePerformance(
                                      timestamp: Timestamp.now(),
                                      exercise: exercise,
                                      duration:
                                          (latest as ResistanceExercisePerformance?)
                                                  ?.duration ??
                                              Duration.zero,
                                      watts: latest?.watts ?? 0,
                                    );
                                    break;
                                  case ExerciseType.weights:
                                    performance = WeightsExercisePerformance(
                                      timestamp: Timestamp.now(),
                                      exercise: exercise,
                                      sets: Sets(
                                        (latest as WeightsExercisePerformance?)
                                                ?.sets
                                                .map((set) => Set(
                                                    weight: set.weight,
                                                    repetitions:
                                                        set.repetitions))
                                                .toList() ??
                                            [
                                              const Set(
                                                  weight: 0, repetitions: 0)
                                            ],
                                      ),
                                    );
                                    break;
                                }

                                PerformancesService.create(performance);

                                setState(() {
                                  _performances[entry.key.toString()] =
                                      performance;
                                });
                              } else {
                                setState(() {
                                  _performances.remove(entry.key.toString());
                                });
                              }

                              widget.onPerformancesChanged(_performances);
                            },
                          ),
                        ],
                      ),
                      title: Text(exercise.name),
                      subtitle: performance != null
                          ? SecondaryText(
                              // TODO: Try to change this into Chip widgets.
                              [
                                if (performance
                                        is! WeightsExercisePerformance &&
                                    performance
                                        is! ResistanceExercisePerformance)
                                  '${performance.calories.round()} cal',
                                if (performance
                                    is WeightsExercisePerformance) ...[
                                  '${(performance.sets.weight / performance.sets.length)} kg',
                                  performance.sets
                                      .map((set) => '${set.repetitions}')
                                      .join("/"),
                                ],
                                if (performance
                                    is ResistanceExercisePerformance) ...[
                                  '${performance.watts} watts',
                                  '${performance.duration.inMinutes} m',
                                ],
                                if (latest != null)
                                  '${(performance.calories / latest.calories * 100).round()}%'
                              ].join(" • "),
                            )
                          : latest != null
                              ? SecondaryText(
                                  // TODO: Try to change this into Chip widgets.
                                  [
                                    if (latest is! WeightsExercisePerformance &&
                                        latest
                                            is! ResistanceExercisePerformance)
                                      '${latest.calories.round()} cal',
                                    if (latest
                                        is WeightsExercisePerformance) ...[
                                      '${(latest.sets.weight / latest.sets.length)} kg',
                                      latest.sets
                                          .map((set) => '${set.repetitions}')
                                          .join("/"),
                                    ],
                                    if (latest
                                        is ResistanceExercisePerformance) ...[
                                      '${latest.watts} watts',
                                      '${latest.duration.inMinutes} m',
                                    ],
                                  ].join(" • "),
                                )
                              : const SecondaryText('--'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (performance != null)
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                ExercisePerformance edited =
                                    await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CreateExercisePerformanceView(
                                      exercisePerformance: performance,
                                    ),
                                  ),
                                );

                                setState(() {
                                  _performances[entry.key.toString()] = edited;
                                });

                                widget.onPerformancesChanged(_performances);
                              },
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ).toList(),
    );
  }
}
