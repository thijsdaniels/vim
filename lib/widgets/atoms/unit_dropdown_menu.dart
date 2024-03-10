import 'package:flutter/material.dart';
import 'package:vim/extensions/string.dart';
import 'package:vim/models/food/amount.dart';

class UnitDropdownMenu extends StatelessWidget {
  final Unit? value;
  final List<Unit> items;
  final void Function(Unit? unit)? onChanged;
  final String label;
  final String? Function(Unit?)? validator;

  const UnitDropdownMenu({
    super.key,
    required this.onChanged,
    this.items = Unit.values,
    this.value = Unit.grams,
    this.label = 'Unit',
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Unit>(
      decoration: InputDecoration(
        label: Text(label),
      ),
      value: value,
      items: items
          .map(
            (item) => DropdownMenuItem<Unit>(
              value: item,
              child: Text(
                item.name.toTitleCase(),
              ),
            ),
          )
          .toList(),
      onChanged: items.length > 1 ? onChanged : null,
      validator: validator,
    );
  }
}
