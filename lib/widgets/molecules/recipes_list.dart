import 'package:flutter/material.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/views/home/food/recipes/recipe_view.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/recipe_list_surface.dart';

class RecipesList extends StatelessWidget {
  final List<Recipe> recipes;
  final ScrollPhysics? physics;
  final EdgeInsets padding;
  final double? elevation;
  final bool showCalories;
  final bool showMacros;
  final bool showTime;

  const RecipesList(
    this.recipes, {
    super.key,
    this.physics,
    this.padding = const EdgeInsets.all(16.0),
    this.elevation,
    this.showCalories = true,
    this.showMacros = true,
    this.showTime = true,
  });

  @override
  Widget build(BuildContext context) {
    if (recipes.isEmpty) {
      return Center(
        child: Icon(
          Icons.more_horiz,
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.25),
        ),
      );
    }

    return StandardList(
      physics: physics,
      padding: padding,
      spacing: 12,
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        Recipe recipe = recipes[index];

        return RecipeListSurface(
          recipe: recipe,
          elevation: elevation,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RecipeView(
                  path: recipe.reference!.path,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
