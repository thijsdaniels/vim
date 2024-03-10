import 'package:flutter/material.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/widgets/atoms/food_icon.dart';
import 'package:vim/widgets/molecules/list_surface.dart';

class IngredientListSurface extends StatelessWidget {
  final void Function()? onTap;
  final double? elevation;

  const IngredientListSurface({
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
      icon: ingredient.icon != null ? FoodIcon(ingredient.icon!) : null,
      title: ingredient.name,
      subtitle: ingredient.brand ?? "--",
      onTap: onTap,
    );
  }
}
