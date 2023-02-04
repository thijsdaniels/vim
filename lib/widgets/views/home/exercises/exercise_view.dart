import 'package:flutter/material.dart';
import 'package:vim/extensions/string.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/services/exercises_service.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';
import 'package:vim/widgets/views/home/exercises/create_exercise_view.dart';

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
                        const SecondaryText('Type'),
                        const SizedBox(width: 32),
                        Text(exercise.type.name.toTitleCase()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
