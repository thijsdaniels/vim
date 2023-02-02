import 'package:flutter/material.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/resistance_exercise.dart';
import 'package:vim/models/exercise/weights_exercise.dart';
import 'package:vim/services/exercises_service.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';
import 'package:vim/widgets/views/home/exercises/create_exercise_view.dart';
import 'package:vim/widgets/views/home/exercises/create_resistance_exercise_view.dart';
import 'package:vim/widgets/views/home/exercises/create_weights_exercise_view.dart';

class ExerciseView extends StatefulWidget {
  final Exercise exercise;

  const ExerciseView({
    super.key,
    required this.exercise,
  });

  @override
  State<ExerciseView> createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  @override
  Widget build(BuildContext context) {
    Exercise exercise = widget.exercise;

    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_rounded),
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    if (exercise is WeightsExercise) {
                      return CreateWeightsExerciseView(exercise: exercise);
                    } else if (exercise is ResistanceExercise) {
                      return CreateResistanceExerciseView(exercise: exercise);
                    } else {
                      return CreateExerciseView(exercise: exercise);
                    }
                  },
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
                if (await confirm()) {
                  ExercisesService.delete(exercise);

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
                      TableRow(
                        children: [
                          const SecondaryText('Name'),
                          const SizedBox(width: 32),
                          Text(exercise.name),
                        ],
                      ),
                      TableRow(
                        children: [
                          const SecondaryText('Calories'),
                          const SizedBox(width: 32),
                          Text(exercise.calories.round().toString())
                        ],
                      ),
                      if (exercise is ResistanceExercise) ...[
                        TableRow(
                          children: [
                            const SecondaryText('Duration'),
                            const SizedBox(width: 32),
                            Row(
                              children: [
                                Text(exercise.duration.inMinutes.toString()),
                                const SizedBox(width: 4),
                                const SecondaryText('minutes'),
                              ],
                            )
                          ],
                        ),
                        TableRow(
                          children: [
                            const SecondaryText('Power'),
                            const SizedBox(width: 32),
                            Row(
                              children: [
                                Text(exercise.watts.toString()),
                                const SizedBox(width: 4),
                                const SecondaryText('watts'),
                              ],
                            )
                          ],
                        ),
                      ],
                      if (exercise is WeightsExercise) ...[
                        TableRow(
                          children: [
                            const SecondaryText('Sets'),
                            const SizedBox(width: 32),
                            Text(exercise.sets.toString())
                          ],
                        ),
                        TableRow(
                          children: [
                            const SecondaryText('Repetitions'),
                            const SizedBox(width: 32),
                            Text(exercise.repetitions.toString())
                          ],
                        ),
                        TableRow(
                          children: [
                            const SecondaryText('Weight'),
                            const SizedBox(width: 32),
                            Text(exercise.weight.toString())
                          ],
                        ),
                      ],
                    ],
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
