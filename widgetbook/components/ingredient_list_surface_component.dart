import 'package:flutter/material.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/widgets/atoms/food_icon.dart';
import 'package:vim/widgets/molecules/ingredient_list_surface.dart';

class IngredientListSurfaceComponent {
  static Widget defaultUseCase(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: IngredientListSurface(
        ingredient: _apple,
      ),
    );
  }
}

Ingredient _apple = Ingredient(
  user: null,
  icon: foodIcons['apple-fruit']!.slug,
  name: 'Apple',
  brand: 'Apple Inc.',
  nutrition: const Nutrition(),
);
