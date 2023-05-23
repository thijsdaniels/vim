import 'package:flutter/material.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
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
      title: Text(ingredient.name),
      subtitle: SecondaryText(ingredient.brand ?? "--"),
      // subtitle: SecondaryText(
      //   // TODO: Try to change this into Chip widgets.
      //   [
      //     if (ingredient.brand != null) ...[
      //       '${ingredient.brand}',
      //     ],
      //     '${ingredient.nutrition.calories.round()} cal',
      //     [
      //       '${ingredient.nutrition.carbohydrates.total?.round() ?? 0}',
      //       '${ingredient.nutrition.proteins.total?.round() ?? 0}',
      //       '${ingredient.nutrition.fats.total?.round() ?? 0}',
      //     ].join("/")
      //   ].join(" • "),
      // ),
      onTap: onTap,
    );
  }
}
