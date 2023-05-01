import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/models/food/recipes.dart';
import 'package:vim/widgets/atoms/icons8_icons_stack.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
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

              return RecipeListItem(recipe: recipe);
            },
          ),
        ),
      ),
    );
  }
}

class RecipeListItem extends StatelessWidget {
  const RecipeListItem({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return ListSurface(
      icon: FutureBuilder(
        future: Future.wait(recipe.ingredientAmounts
            .map((ingredientAmount) => ingredientAmount.ingredient)),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          return Icons8IconStack(
            icons: snapshot.data!.map((ingredient) => ingredient.icon).toList(),
          );
        },
      ),
      title: Text(recipe.name),
      subtitle: FutureBuilder(
        future: recipe.nutrition,
        builder: (context, snapshot) {
          return SecondaryText(
            [
              '${recipe.ingredientAmounts.amount.round()} grams',
              if (snapshot.hasData) '${snapshot.data!.calories.round()} kcal',
            ].join(" • "),
          );
        },
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RecipeView(recipe: recipe),
          ),
        );
      },
    );
  }
}
