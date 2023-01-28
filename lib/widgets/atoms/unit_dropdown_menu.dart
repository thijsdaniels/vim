import 'package:flutter/material.dart';
import 'package:vim/extensions/string.dart';
import 'package:vim/models/amount.dart';

class UnitDropdownMenu extends StatelessWidget {
  final Unit initialSelection;
  final TextEditingController? controller;
  final void Function(Unit? unit)? onSelected;

  const UnitDropdownMenu({
    super.key,
    this.initialSelection = Unit.grams,
    this.controller,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<Unit>(
      initialSelection: initialSelection,
      controller: controller,
      enableSearch: false,
      label: const Text('Unit'),
      dropdownMenuEntries: [
        for (final Unit unit in Unit.values)
          DropdownMenuEntry(
            value: unit,
            label: unit.name.toTitleCase(),
          )
      ],
      onSelected: onSelected,
    );
  }
}
