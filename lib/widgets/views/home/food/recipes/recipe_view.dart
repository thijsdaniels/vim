import 'package:flutter/material.dart';
import 'package:vim/extensions/num.dart';
import 'package:vim/models/food/ingredient_amounts.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/services/recipes_service.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:vim/widgets/molecules/nutrition_table.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';
import 'package:vim/widgets/views/home/food/recipes/create_ingredient_amount_view.dart';
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
  Recipe? _recipe;

  @override
  void initState() {
    super.initState();
    _recipe = widget.recipe;
  }

  @override
  Widget build(BuildContext context) {
    if (_recipe == null) {
      return const CircularProgressIndicator();
    }

    Recipe recipe = _recipe!;

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
      body: StandardList(
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
                    ? NutritionTable(nutrition: snapshot.data!)
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
          SimpleCard(
            title: 'Ingredients',
            actions: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                IngredientAmountReference? ingredientAmount =
                    await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CreateIngredientAmountView(),
                  ),
                );

                if (ingredientAmount != null) {
                  setState(() {
                    recipe.ingredientAmounts.add(ingredientAmount);
                    RecipesService.update(recipe);
                  });
                }
              },
            ),
            child: StandardList(
              padding: EdgeInsets.zero,
              itemCount: recipe.ingredientAmounts.length,
              itemBuilder: (context, index) {
                var ingredientAmount = recipe.ingredientAmounts.get(index);

                return Card(
                  elevation: 4,
                  child: ListSurface(
                    elevation: 4,
                    icon: FutureBuilder(
                      future: ingredientAmount.ingredient,
                      builder: (context, snapshot) =>
                          (snapshot.hasData && snapshot.data!.icon != null)
                              ? Icons8Icon.asset(snapshot.data!.icon!, size: 48)
                              : const CircularProgressIndicator(),
                    ),
                    title: FutureBuilder(
                      future: ingredientAmount.ingredient,
                      builder: (context, snapshot) => snapshot.hasData
                          ? Text(snapshot.data!.name)
                          : const Text('...'),
                    ),
                    subtitle: SecondaryText(
                      '${ingredientAmount.amount.decimals(2).toString()} grams',
                    ),
                    actions: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            var edited = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    CreateIngredientAmountView(
                                  ingredientAmount: ingredientAmount,
                                ),
                              ),
                            );

                            setState(() {
                              recipe.ingredientAmounts.replace(index, edited);
                              RecipesService.update(recipe);
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              recipe.ingredientAmounts.removeAt(index);
                              RecipesService.update(recipe);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
