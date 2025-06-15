import 'package:flutter/material.dart';
import 'package:vim/extensions/recipes.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/views/recipes/recipe_view.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/recipe_list_surface.dart';
import 'package:vim/widgets/molecules/searchable_list.dart';

class RecipesList extends StatelessWidget {
  final List<Recipe> recipes;
  final ScrollPhysics? physics;
  final EdgeInsets padding;
  final double? elevation;
  final bool searchable;

  const RecipesList(
    this.recipes, {
    super.key,
    this.physics,
    this.padding = const EdgeInsets.all(16.0),
    this.elevation,
    this.searchable = false,
  });

  @override
  Widget build(BuildContext context) {
    if (recipes.isEmpty) {
      return Center(
        child: Icon(
          Icons.more_horiz,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.25),
        ),
      );
    }

    if (!searchable) {
      return StandardList(
        spacing: 12,
        physics: physics,
        padding: padding,
        itemCount: recipes.length,
        itemBuilder: (context, index) => RecipeListSurface(
          elevation: elevation,
          recipe: recipes[index],
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RecipeView(
                  path: recipes[index].reference!.path,
                ),
              ),
            );
          },
        ),
      );
    }

    return SearchableList<Recipe>(
      spacing: 12,
      physics: physics,
      padding: padding,
      items: recipes.toFuzzy(),
      itemBuilder: (context, recipe, similarity) => RecipeListSurface(
        elevation: elevation,
        recipe: recipe,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RecipeView(
                path: recipe.reference!.path,
              ),
            ),
          );
        },
      ),
    );
  }
}
