import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/models/food/recipes.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/recipe_list_item.dart';
import 'package:vim/widgets/views/home/food/recipes/create_recipe_view.dart';
import 'package:vim/widgets/views/home/food/recipes/recipe_view.dart';

class RecipesView extends StatelessWidget {
  const RecipesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateRecipeView(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Consumer<Recipes>(
          builder: (context, recipes, child) => StandardList(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              Recipe recipe = recipes.get(index);

              return RecipeListItem(
                recipe: recipe,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RecipeView(recipe: recipe),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
