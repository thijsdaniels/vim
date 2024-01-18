import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/widgets/molecules/ingredient_list_surface.dart';

Ingredient apple = Ingredient(
  user: null,
  icon: 'apple',
  name: 'Apple',
  brand: 'Apple Inc.',
  nutrition: const Nutrition(),
);

class IngredientListSurfaceStory extends Story {
  IngredientListSurfaceStory()
      : super(
          name: 'Widgets/IngredientListSurface',
          builder: (context) => ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: IngredientListSurface(
              ingredient: apple,
            ),
          ),
        );
}
