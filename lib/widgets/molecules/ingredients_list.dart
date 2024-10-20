import 'package:flutter/material.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/views/ingredients/ingredient_view.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/ingredient_list_surface.dart';
import 'package:vim/widgets/molecules/searchable_list.dart';

class IngredientsList extends StatelessWidget {
  const IngredientsList(
    this.ingredients, {
    super.key,
    this.elevation,
    this.physics,
    this.padding = const EdgeInsets.all(16),
    this.searchable = false,
  });

  final List<Ingredient> ingredients;
  final ScrollPhysics? physics;
  final EdgeInsets padding;
  final double? elevation;
  final bool searchable;

  @override
  Widget build(BuildContext context) {
    if (ingredients.isEmpty) {
      return Center(
        child: Icon(
          Icons.more_horiz,
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.25),
        ),
      );
    }

    if (!searchable) {
      return StandardList(
        spacing: 12,
        physics: physics,
        padding: padding,
        itemCount: ingredients.length,
        itemBuilder: (context, index) => IngredientListSurface(
          elevation: elevation,
          ingredient: ingredients[index],
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => IngredientView(
                  path: ingredients[index].reference!.path,
                ),
              ),
            );
          },
        ),
      );
    }

    return SearchableList<Ingredient>(
      spacing: 12,
      physics: physics,
      padding: padding,
      items: ingredients,
      itemToText: (ingredient) => ingredient.searchableText,
      itemBuilder: (context, ingredient, similarity) => IngredientListSurface(
        elevation: elevation,
        ingredient: ingredient,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => IngredientView(
                path: ingredient.reference!.path,
              ),
            ),
          );
        },
      ),
    );
  }
}
