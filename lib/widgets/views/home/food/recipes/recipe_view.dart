import 'package:flutter/material.dart';
import 'package:vim/extensions/num.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/services/recipes_service.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/molecules/nutrition_table.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';
import 'package:vim/widgets/views/home/food/recipes/create_recipe_view.dart';

class RecipeView extends StatefulWidget {
  final Recipe recipe;

  const RecipeView({
    super.key,
    required this.recipe,
  });

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  @override
  Widget build(BuildContext context) {
    Recipe recipe = widget.recipe;

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateRecipeView(
                    recipe: recipe,
                  ),
                ),
              );
            },
          ),
          WithConfirmationDialog(
            title: recipe.name,
            description: 'Are you sure you want to delete this recipe?',
            builder: (context, confirm) => IconButton(
              icon: const Icon(Icons.delete_rounded),
              onPressed: () async {
                if (await confirm()) {
                  RecipesService.delete(recipe);

                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SimpleCard(
                title: 'Details',
                child: Center(
                  child: Table(
                    defaultColumnWidth: const IntrinsicColumnWidth(),
                    children: [
                      TableRow(
                        children: [
                          const SecondaryText('Name'),
                          const SizedBox(width: 32),
                          Text(recipe.name),
                        ],
                      ),
                      TableRow(
                        children: [
                          const SecondaryText('Servings'),
                          const SizedBox(width: 32),
                          Text(recipe.servings.toString()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SimpleCard(
                title: 'Nutrition',
                child: Center(
                  child: FutureBuilder(
                    future: recipe.nutrition,
                    builder: (context, snapshot) => snapshot.hasData
                        ? NutritionTable(
                            nutrition: snapshot.data!,
                          )
                        : const CircularProgressIndicator(),
                  ),
                ),
              ),
              SimpleCard(
                title: 'Ingredients',
                child: Center(
                  child: Table(
                    defaultColumnWidth: const IntrinsicColumnWidth(),
                    children: recipe.ingredientAmounts
                        .map(
                          (ingredientAmount) => TableRow(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FutureBuilder(
                                    future: ingredientAmount.ingredient,
                                    builder: (context, snapshot) =>
                                        snapshot.hasData
                                            ? Text(snapshot.data!.name)
                                            : const Text('...'),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 32),
                              Row(
                                children: [
                                  Text(
                                    ingredientAmount.amount
                                        .decimals(2)
                                        .toString(),
                                  ),
                                  const SizedBox(width: 4),
                                  const SecondaryText('g'),
                                ],
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
