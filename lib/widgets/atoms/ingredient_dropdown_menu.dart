import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/ingredients.dart';

class IngredientDropdownMenu extends StatelessWidget {
  final Ingredient? initialSelection;
  final TextEditingController? controller;
  final void Function(Ingredient? ingredient)? onSelected;

  const IngredientDropdownMenu({
    super.key,
    this.initialSelection,
    this.controller,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Ingredients>(
      builder: (context, ingredients, child) {
        return DropdownMenu<Ingredient>(
          initialSelection: initialSelection,
          controller: controller,
          menuHeight: 256,
          enableFilter: true,
          label: const Text('Ingredient'),
          dropdownMenuEntries: ingredients.map((ingredient) {
            return DropdownMenuEntry(
              value: ingredient,
              label: ingredient.name,
            );
          }).toList(),
          onSelected: onSelected,
        );
      },
    );
  }
}
