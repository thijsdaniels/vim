import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercises.dart';
import 'package:vim/models/exercise/resistance_exercise.dart';
import 'package:vim/models/exercise/weights_exercise.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/views/home/exercises/create_exercise_view.dart';
import 'package:vim/widgets/views/home/exercises/create_resistance_exercise_view.dart';
import 'package:vim/widgets/views/home/exercises/create_weights_exercise_view.dart';
import 'package:vim/widgets/views/home/exercises/exercise_view.dart';

class ExercisesView extends StatefulWidget {
  const ExercisesView({super.key});

  @override
  State<ExercisesView> createState() => _ExercisesViewState();
}

class _ExercisesViewState extends State<ExercisesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercises'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort_rounded),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_alt_rounded),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'weightsExerciseFab',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CreateWeightsExerciseView(),
                ),
              );
            },
            child: const Icon(Icons.fitness_center),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            heroTag: 'resistanceExerciseFab',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CreateResistanceExerciseView(),
                ),
              );
            },
            child: const Icon(Icons.directions_bike),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            heroTag: 'exerciseFab',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CreateExerciseView(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<Exercises>(
          builder: (context, exercises, child) => ListView.builder(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              Exercise exercise = exercises.get(index);

              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ExerciseView(exercise: exercise),
                      ),
                    );
                  },
                  title: Text(exercise.name),
                  subtitle: SecondaryText(
                    // TODO: Try to change this into Chip widgets.
                    [
                      '${exercise.calories.round()} cal',
                      if (exercise is WeightsExercise) ...[
                        [
                          '${exercise.sets}',
                          '${exercise.repetitions}',
                        ].join("×"),
                        '${exercise.weight} kg',
                      ],
                      if (exercise is ResistanceExercise) ...[
                        '${exercise.duration.inMinutes} m',
                        '${exercise.watts} watts',
                      ],
                    ].join(" • "),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
