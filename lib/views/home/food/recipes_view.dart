import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/views/home/food/recipes/create_recipe_view.dart';
import 'package:vim/widgets/atoms/floating_action_surface.dart';
import 'package:vim/widgets/molecules/recipes_list.dart';

class RecipesView extends StatelessWidget {
  const RecipesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionSurface(
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
        child: Consumer<List<Recipe>>(
          builder: (context, recipes, child) => RecipesList(recipes),
        ),
      ),
    );
  }
}
