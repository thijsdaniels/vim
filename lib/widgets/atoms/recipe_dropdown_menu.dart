import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/models/food/recipes.dart';

class RecipeDropdownMenu extends StatelessWidget {
  final Recipe? initialSelection;
  final TextEditingController? controller;
  final void Function(Recipe? recipe)? onSelected;

  const RecipeDropdownMenu({
    super.key,
    this.initialSelection,
    this.controller,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Recipes>(
      builder: (context, recipes, child) {
        return DropdownMenu<Recipe>(
          initialSelection: initialSelection,
          controller: controller,
          menuHeight: 256,
          enableFilter: true,
          label: const Text('Recipe'),
          dropdownMenuEntries: recipes.map((recipe) {
            return DropdownMenuEntry(
              value: recipe,
              label: recipe.name,
            );
          }).toList(),
          onSelected: onSelected,
        );
      },
    );
  }
}
