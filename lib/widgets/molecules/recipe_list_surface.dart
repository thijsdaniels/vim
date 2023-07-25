import 'package:flutter/material.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/widgets/atoms/recipe_icon.dart';
import 'package:vim/widgets/molecules/list_surface.dart';

class RecipeListSurface extends StatelessWidget {
  final void Function()? onTap;
  final double? elevation;

  const RecipeListSurface({
    super.key,
    required this.recipe,
    this.onTap,
    this.elevation,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return ListSurface(
      elevation: elevation,
      icon: RecipeIcon(recipe),
      title: recipe.name,
      subtitle: '${recipe.ingredientAmounts.length} Ingredients',
      onTap: onTap,
    );

    // return FutureBuilder(
    //   future: recipe.nutrition,
    //   builder: (context, snapshot) => ListSurface(
    //     elevation: elevation,
    //     icon: RecipeIcon(recipe),
    //     title: recipe.name,
    //     subtitle: [
    //       '${recipe.ingredientAmounts.amount.round()} grams',
    //       if (snapshot.hasData) '${snapshot.data!.calories?.round() ?? 0} kcal',
    //     ].join(" • "),
    //     onTap: onTap,
    //   ),
    // );
  }
}
