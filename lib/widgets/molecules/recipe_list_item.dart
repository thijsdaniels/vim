import 'package:flutter/material.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/widgets/atoms/icons8_icons_stack.dart';
import 'package:vim/widgets/molecules/list_surface.dart';

class RecipeListItem extends StatelessWidget {
  final void Function()? onTap;
  final double? elevation;

  const RecipeListItem({
    super.key,
    required this.recipe,
    this.onTap,
    this.elevation,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: recipe.nutrition,
      builder: (context, snapshot) => ListSurface(
        elevation: elevation,
        icon: FutureBuilder(
          future: Future.wait(recipe.ingredientAmounts
              .map((ingredientAmount) => ingredientAmount.ingredient)),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            return Icons8IconStack(
              icons:
                  snapshot.data!.map((ingredient) => ingredient.icon).toList(),
            );
          },
        ),
        title: recipe.name,
        subtitle: [
          '${recipe.ingredientAmounts.amount.round()} grams',
          if (snapshot.hasData) '${snapshot.data!.calories.round()} kcal',
        ].join(" • "),
        onTap: onTap,
      ),
    );
  }
}
