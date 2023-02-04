import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercises.dart';

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
    return Consumer<Exercises>(
      builder: (context, exercises, child) {
        return DropdownMenu<Exercise>(
          initialSelection: initialSelection,
          controller: controller,
          menuHeight: 256,
          enableFilter: true,
          label: const Text('Exercise'),
          dropdownMenuEntries: exercises.map((exercise) {
            return DropdownMenuEntry(
              value: exercise,
              label: exercise.name,
            );
          }).toList(),
          onSelected: onSelected,
          enabled: enabled,
        );
      },
    );
  }
}
