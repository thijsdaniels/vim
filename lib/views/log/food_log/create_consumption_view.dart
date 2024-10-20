import 'package:flutter/material.dart';
import 'package:vim/models/document.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/ingredient_consumption.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/models/food/recipe_consumption.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/ingredients_collection_group.dart';
import 'package:vim/services/recipes_collection_group.dart';
import 'package:vim/views/log/food_log/create_ingredient_consumption_view.dart';
import 'package:vim/views/log/food_log/create_quick_track_consumption_view.dart';
import 'package:vim/views/log/food_log/create_recipe_consumption_view.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/ingredient_list_surface.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:vim/widgets/molecules/recipe_list_surface.dart';
import 'package:vim/widgets/molecules/searchable_list.dart';

class CreateConsumptionView extends StatelessWidget {
  const CreateConsumptionView({super.key});

  @override
  Widget build(BuildContext context) {
    var user = User.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Consumption"),
        actions: [
          IconButton(
            onPressed: () async {
              var navigator = Navigator.of(context);

              navigator.pop();

              await navigator.push(
                MaterialPageRoute(
                  builder: (context) => const CreateQuickTrackConsumptionView(),
                ),
              );
            },
            icon: const Icon(Icons.flash_on_rounded),
          )
        ],
      ),
      body: StreamBuilder(
        stream: RecipesCollectionGroup.instance.all(
          users: [user.reference!, ...user.following],
        ),
        builder: (context, recipes) => StreamBuilder(
          stream: IngredientsCollectionGroup.instance.all(
            users: [user.reference!, ...user.following],
          ),
          builder: (context, ingredients) => SearchableList<NamedDocument>(
            barHintText: "Search",
            items: [
              ...(recipes.data ?? []),
              ...(ingredients.data ?? []),
            ],
            itemToText: (entry) => entry.searchableText,
            itemBuilder: (context, entry, similarity) => SearchResult(entry),
            noQueryBuilder: (context, entries) => const StandardList(
              children: [
                ListSurface(
                  title: "Dummy Suggestion #1",
                ),
                ListSurface(
                  title: "Dummy Suggestion #2",
                ),
                ListSurface(
                  title: "Dummy Suggestion #3",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchResult extends StatelessWidget {
  final dynamic entry;

  const SearchResult(
    this.entry, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (entry is Recipe) {
      return RecipeSearchResult(entry);
    } else if (entry is Ingredient) {
      return IngredientSearchResult(entry);
    } else {
      throw ArgumentError("Invalid entry type.");
    }
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
    return RecipeListSurface(
      elevation: 4,
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
    return IngredientListSurface(
      elevation: 4,
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
          navigator.pop(consumption);
        }
      },
    );
  }
}
