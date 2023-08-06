import 'package:flutter/material.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/ingredient_list_surface.dart';
import 'package:vim/views/home/food/ingredients/ingredient_view.dart';

class IngredientsList extends StatelessWidget {
  const IngredientsList(
    this.ingredients, {
    super.key,
    this.elevation,
    this.physics,
    this.padding = const EdgeInsets.all(16),
  });

  final List<Ingredient> ingredients;
  final ScrollPhysics? physics;
  final EdgeInsets padding;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
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
}
