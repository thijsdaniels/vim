import 'package:flutter/material.dart';
import 'package:vim/extensions/ingredient_amounts.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/widgets/atoms/recipe_icon.dart';
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
        icon: RecipeIcon(recipe),
        title: recipe.name,
        subtitle: [
          '${recipe.ingredientAmounts.amount.round()} grams',
          if (snapshot.hasData) '${snapshot.data!.calories?.round()} kcal',
        ].join(" • "),
        onTap: onTap,
      ),
    );
  }
}
