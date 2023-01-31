import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/recipe.dart';
import 'package:vim/models/recipes.dart';
import 'package:vim/services/recipes_service.dart';
import 'package:vim/widgets/views/home/recipes/create_recipe_view.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';

class RecipesView extends StatefulWidget {
  const RecipesView({super.key});

  @override
  State<RecipesView> createState() => _RecipesViewState();
}

class _RecipesViewState extends State<RecipesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort_rounded),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_alt_rounded),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  CreateRecipeView(recipe: recipe),
                            ),
                          );
                        },
                      ),
                      WithConfirmationDialog(
                        title: recipe.name,
                        description:
                            'Are you sure you want to delete this recipe?',
                        builder: (context, confirm) => IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            if (await confirm()) {
                              RecipesService.delete(recipe);
                            }
                          },
                        ),
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
}
