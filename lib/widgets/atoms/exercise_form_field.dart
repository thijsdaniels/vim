import 'package:flutter/material.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/widgets/atoms/exercise_icon.dart';
import 'package:vim/widgets/atoms/search_form_field.dart';

class ExerciseFormField extends StatelessWidget {
  final List<Exercise> exercises;
  final Exercise? selection;
  final void Function(Exercise? exercise)? onSelected;

  const ExerciseFormField({
    super.key,
    required this.exercises,
    this.selection,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SearchFormField(
      decoration: const InputDecoration(
        labelText: 'Exercise',
      ),
      options: exercises,
      titleBuilder: (exercise) => exercise.name,
      subtitleBuilder: (exercise) async =>
          (await exercise.equipment?.first)?.name,
      iconBuilder: (exercise) => ExerciseIcon(exercise),
      selection: selection,
      onSelected: onSelected,
    );
  }
}
