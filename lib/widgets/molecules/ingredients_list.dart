import 'package:flutter/material.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/ingredient_list_surface.dart';
import 'package:vim/widgets/views/home/food/ingredients/ingredient_view.dart';

class IngredientsList extends StatelessWidget {
  const IngredientsList(this.ingredients, {super.key});

  final List<Ingredient> ingredients;

  @override
  Widget build(BuildContext context) {
    return StandardList(
      spacing: 12,
      itemCount: ingredients.length,
      itemBuilder: (context, index) => IngredientListSurface(
        ingredient: ingredients[index],
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => IngredientView(
                id: ingredients[index].reference!.id,
              ),
            ),
          );
        },
      ),
    );
  }
}
