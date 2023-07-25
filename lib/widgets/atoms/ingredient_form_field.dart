import 'package:flutter/material.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';
import 'package:vim/widgets/atoms/search_form_field.dart';

class IngredientFormField extends StatelessWidget {
  final List<Ingredient> ingredients;
  final Ingredient? selection;
  final void Function(Ingredient? ingredient)? onSelected;

  const IngredientFormField({
    super.key,
    required this.ingredients,
    this.selection,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SearchFormField(
      decoration: const InputDecoration(
        labelText: 'Ingredient',
      ),
      options: ingredients,
      titleBuilder: (ingredient) => ingredient.name,
      subtitleBuilder: (ingredient) => ingredient.brand,
      iconBuilder: (ingredient) =>
          ingredient.icon != null ? Icons8Icon(ingredient.icon!) : null,
      selection: selection,
      onSelected: onSelected,
    );
  }
}
