import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vim/extensions/ingredients.dart';
import 'package:vim/models/food/ingredient.dart';
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
          color:
              Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.25),
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
          onTap: () => context.push('/${ingredients[index].reference!.path}'),
        ),
      );
    }

    return SearchableList<Ingredient>(
      spacing: 12,
      physics: physics,
      padding: padding,
      items: ingredients.toFuzzy(),
      itemBuilder: (context, ingredient, similarity) => IngredientListSurface(
        elevation: elevation,
        ingredient: ingredient,
        onTap: () => context.push('/${ingredient.reference!.path}'),
      ),
    );
  }
}
