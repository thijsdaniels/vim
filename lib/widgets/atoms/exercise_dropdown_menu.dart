import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/exercise.dart';

class ExerciseDropdownMenu extends StatelessWidget {
  final Exercise? initialSelection;
  final TextEditingController? controller;
  final void Function(Exercise? exercise)? onSelected;
  final bool enabled;

  const ExerciseDropdownMenu({
    super.key,
    this.initialSelection,
    this.controller,
    this.onSelected,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<List<Exercise>>(
      builder: (context, exercises, child) {
        return Autocomplete<Exercise>(
          initialValue: controller?.value,
          optionsBuilder: (value) => exercises.where(
            (exercise) =>
                exercise.name.toLowerCase().contains(value.text.toLowerCase()),
          ),
          displayStringForOption: (exercise) => exercise.name,
          onSelected: onSelected,
        );
      },
    );
  }
}
