import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/routine.dart';

class RoutineDropdownMenu extends StatelessWidget {
  final Routine? initialSelection;
  final TextEditingController? controller;
  final void Function(Routine? routine)? onSelected;

  const RoutineDropdownMenu({
    super.key,
    this.initialSelection,
    this.controller,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Iterable<Routine>>(
      builder: (context, routines, child) {
        return DropdownMenu<Routine>(
          initialSelection: initialSelection,
          controller: controller,
          menuHeight: 256,
          enableFilter: true,
          label: const Text('Routine'),
          dropdownMenuEntries: routines.map((routine) {
            return DropdownMenuEntry(
              value: routine,
              label: routine.name,
            );
          }).toList(),
          onSelected: onSelected,
        );
      },
    );
  }
}
