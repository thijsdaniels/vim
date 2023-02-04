import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/extensions/string.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercises.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/views/home/exercises/create_exercise_view.dart';
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
                  subtitle: SecondaryText(exercise.type.name.toTitleCase()),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
