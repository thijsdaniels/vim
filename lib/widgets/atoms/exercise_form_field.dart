import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/widgets/atoms/exercise_icon.dart';
import 'package:vim/widgets/atoms/search_form_field.dart';

class ExerciseFormField extends StatelessWidget {
  final Exercise? selection;
  final void Function(Exercise? exercise)? onSelected;

  const ExerciseFormField({
    super.key,
    this.selection,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<List<Exercise>>(
      builder: (context, exercises, child) {
        return SearchFormField(
          decoration: const InputDecoration(
            labelText: 'Exercise',
          ),
          options: exercises,
          titleBuilder: (exercise) => exercise.name,
          subtitleBuilder: (exercise) => exercise.type.name,
          iconBuilder: (exercise) => ExerciseIcon(exercise),
          selection: selection,
          onSelected: onSelected,
        );
      },
    );
  }
}
