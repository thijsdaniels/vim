import 'package:flutter/material.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/widgets/atoms/icons8_icons_stack.dart';

class RecipeIcon extends StatelessWidget {
  final double elevation;
  final Recipe recipe;

  const RecipeIcon(
    this.recipe, {
    super.key,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(
        recipe.ingredientAmounts
            .map((ingredientAmount) => ingredientAmount.ingredient),
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        return Icons8IconStack(
          icons: snapshot.data!.map((ingredient) => ingredient.icon).toList(),
        );
      },
    );
  }
}
