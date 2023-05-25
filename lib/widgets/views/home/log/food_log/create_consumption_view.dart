import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/ingredient_consumption.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/models/food/recipe_consumption.dart';
import 'package:vim/widgets/molecules/ingredient_list_tile.dart';
import 'package:vim/widgets/molecules/recipe_list_item.dart';
import 'package:vim/widgets/views/home/log/food_log/create_ingredient_consumption_view.dart';
import 'package:vim/widgets/views/home/log/food_log/create_quick_track_consumption_view.dart';
import 'package:vim/widgets/views/home/log/food_log/create_recipe_consumption_view.dart';

class CreateConsumptionView extends StatelessWidget {
  const CreateConsumptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Consumption"),
        actions: [
          IconButton(
            onPressed: () async {
              var navigator = Navigator.of(context);

              navigator.pop();

              Consumption? consumption = await navigator.push(
                MaterialPageRoute(
                  builder: (context) => const CreateQuickTrackConsumptionView(),
                ),
              );

              if (consumption != null) {
                navigator.pop(consumption);
              }
            },
            icon: const Icon(Icons.flash_on_rounded),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<List<Recipe>>(
          builder: (context, recipes, _) => Consumer<List<Ingredient>>(
            builder: (context, ingredients, _) => SearchAnchor.bar(
              viewElevation: 4,
              isFullScreen: true,
              barHintText: "Search",
              suggestionsBuilder: (context, controller) {
                return [
                  const SizedBox(height: 6),
                  ...recipes
                      .where((recipe) => isMatch(recipe.name, controller))
                      .map(
                        (recipe) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: RecipeSearchResult(recipe),
                        ),
                      ),
                  ...ingredients
                      .where(
                        (ingredient) => isMatch(ingredient.name, controller),
                      )
                      .map(
                        (ingredient) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: IngredientSearchResult(ingredient),
                        ),
                      ),
                  const SizedBox(height: 6),
                ];
              },
            ),
          ),
        ),
      ),
    );
  }

  bool isMatch(String text, SearchController controller) {
    return text.toLowerCase().contains(controller.value.text.toLowerCase());
  }
}

class RecipeSearchResult extends StatelessWidget {
  final Recipe recipe;

  const RecipeSearchResult(
    this.recipe, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RecipeListItem(
      elevation: 8,
      recipe: recipe,
      onTap: () async {
        var navigator = Navigator.of(context);

        RecipeConsumption? consumption = await navigator.push(
          MaterialPageRoute(
            builder: (context) => CreateRecipeConsumptionView(
              recipe: recipe,
            ),
          ),
        );

        if (consumption != null) {
          navigator.pop();
          navigator.pop(consumption);
        }
      },
    );
  }
}

class IngredientSearchResult extends StatelessWidget {
  final Ingredient ingredient;

  const IngredientSearchResult(
    this.ingredient, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IngredientListTile(
      elevation: 8,
      ingredient: ingredient,
      onTap: () async {
        var navigator = Navigator.of(context);

        IngredientConsumption? consumption = await navigator.push(
          MaterialPageRoute(
            builder: (context) => CreateIngredientConsumptionView(
              ingredient: ingredient,
            ),
          ),
        );

        if (consumption != null) {
          navigator.pop();
          navigator.pop(consumption);
        }
      },
    );
  }
}
