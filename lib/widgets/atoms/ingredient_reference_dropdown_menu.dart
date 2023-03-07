import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/food/ingredients.dart';

/// TODO: Can I somehow combine this widget with the `IngredientDropdownMenu`?
class IngredientReferenceDropdownMenu extends StatelessWidget {
  final DocumentReference? initialSelection;
  final TextEditingController? controller;
  final void Function(DocumentReference? ingredient)? onSelected;

  const IngredientReferenceDropdownMenu({
    super.key,
    this.initialSelection,
    this.controller,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Ingredients>(
      builder: (context, ingredients, child) {
        return DropdownMenu<DocumentReference>(
          initialSelection: initialSelection,
          controller: controller,
          menuHeight: 256,
          enableFilter: true,
          label: const Text('Ingredient'),
          dropdownMenuEntries: ingredients.map((ingredient) {
            return DropdownMenuEntry(
              value: ingredient.reference!,
              label: ingredient.brand == null
                  ? ingredient.name
                  : '${ingredient.name} (${ingredient.brand})',
            );
          }).toList(),
          onSelected: onSelected,
        );
      },
    );
  }
}
