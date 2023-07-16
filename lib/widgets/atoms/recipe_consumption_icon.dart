import 'package:flutter/material.dart';
import 'package:vim/models/food/recipe_consumption.dart';
import 'package:vim/widgets/atoms/icons8_icons_stack.dart';

class RecipeConsumptionIcon extends StatelessWidget {
  final double elevation;
  final RecipeConsumption consumption;

  const RecipeConsumptionIcon(
    this.consumption, {
    super.key,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    /// TODO: Since I copied this logic from the `RoutinePerformanceIcon`, I'm
    /// building the icon stack not with the recipe's ingredients, but with the
    /// recipe's consumptions. This is fine, but I should consider whether it's
    /// better to use the ingredients instead. I suppose it might be a good
    /// thing that changing the consumed ingredients will be reflected in the
    /// icon stack, even if the recipe itself was not changed.
    return StreamBuilder(
      stream: consumption.consumptions,
      builder: (context, snapshot) {
        return Icons8IconStack(
          icons: snapshot.data
                  ?.map(
                    (ingredientConsumption) =>
                        ingredientConsumption.ingredient.snapshot.icon,
                  )
                  .toList() ??
              [],
        );
      },
    );
  }
}
