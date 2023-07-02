import 'package:flutter/material.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';
import 'package:vim/widgets/molecules/list_surface.dart';

class IngredientListTile extends StatelessWidget {
  final void Function()? onTap;
  final double? elevation;

  const IngredientListTile({
    super.key,
    required this.ingredient,
    this.onTap,
    this.elevation,
  });

  final Ingredient ingredient;

  @override
  Widget build(BuildContext context) {
    return ListSurface(
      elevation: elevation,
      icon: ingredient.icon != null ? Icons8Icon(ingredient.icon!) : null,
      title: ingredient.name,
      subtitle: ingredient.brand ?? "--",
      onTap: onTap,
    );
  }
}
