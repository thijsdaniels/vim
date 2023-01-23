import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/recipe.dart';
import 'package:vim/models/recipes.dart';
import 'package:vim/services/recipes_service.dart';
import 'package:vim/widgets/dialogs/create_recipe_dialog.dart';

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
          Recipe? recipe = await _showCreateRecipeDialog(
            context: context,
          );

          if (recipe != null) {
            RecipesService.create(recipe);
          }

          return;
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
                  subtitle: Text(
                      '${recipe.nutrition.calories.round().toString()} kcal'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          Recipe? edited = await _showCreateRecipeDialog(
                            context: context,
                            recipe: recipe,
                          );

                          if (edited != null) {
                            RecipesService.update(edited);
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          RecipesService.delete(recipe);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<Recipe?> _showCreateRecipeDialog({
    required BuildContext context,
    Recipe? recipe,
  }) {
    return showDialog<Recipe>(
      context: context,
      builder: (BuildContext context) {
        return CreateRecipeDialog(
          recipe: recipe,
        );
      },
    );
  }
}
