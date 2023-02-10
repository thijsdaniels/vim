import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/models/food/recipes.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/views/home/food/recipes/create_recipe_view.dart';
import 'package:vim/widgets/views/home/food/recipes/recipe_view.dart';

class RecipesView extends StatefulWidget {
  const RecipesView({super.key});

  @override
  State<RecipesView> createState() => _RecipesViewState();
}

class _RecipesViewState extends State<RecipesView> {
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
          builder: (context, recipes, child) => ListView.builder(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              Recipe recipe = recipes.get(index);

              return Card(
                child: ListTile(
                  title: Text(recipe.name),
                  subtitle: FutureBuilder(
                    future: recipe.nutrition,
                    builder: (context, snapshot) {
                      return SecondaryText(
                        [
                          '${recipe.ingredientAmounts.amount.round()} grams',
                          if (snapshot.hasData)
                            '${snapshot.data!.calories.round()} kcal',
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
