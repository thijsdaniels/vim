import 'package:flutter/material.dart';
import 'package:vim/extensions/num.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/ingredient_amount.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/services/consumptions_service.dart';
import 'package:vim/services/recipes_service.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/atoms/stats_table.dart';
import 'package:vim/widgets/molecules/consumptions_list.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:vim/widgets/molecules/nutrition_table.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';
import 'package:vim/widgets/views/home/food/recipes/create_ingredient_amount_view.dart';
import 'package:vim/widgets/views/home/food/recipes/create_recipe_view.dart';
import 'package:vim/widgets/views/loading_view.dart';
import 'package:vim/widgets/views/not_found_view.dart';

class RecipeView extends StatelessWidget {
  final String id;

  const RecipeView({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Recipe?>(
      stream: RecipesService.of(context).get(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingView();
        }

        if (!snapshot.hasData) {
          return const NotFoundView();
        }

        Recipe recipe = snapshot.requireData!;

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
                    var navigator = Navigator.of(context);
                    if (await confirm()) {
                      RecipesService.of(context).delete(recipe);
                      navigator.pop();
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
                child: StatsTable(
                  children: [
                    StatsRow('Name', recipe.name),
                    StatsRow('Servings', recipe.servings.toString()),
                  ],
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
                actions: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () async {
                      IngredientAmount? ingredientAmount =
                          await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              const CreateIngredientAmountView(),
                        ),
                      );

                      if (ingredientAmount != null) {
                        recipe.ingredientAmounts.add(ingredientAmount);
                        RecipesService.of(context).update(recipe);
                      }
                    },
                  ),
                ],
                child: StandardList(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: recipe.ingredientAmounts.length,
                  itemBuilder: (context, index) {
                    var ingredientAmount = recipe.ingredientAmounts[index];

                    return IngredientAmountListSurface(
                      ingredientAmount,
                      onChange: (value) {
                        recipe.ingredientAmounts[index] = value;
                        RecipesService.of(context).update(recipe);
                      },
                      onDelete: () {
                        recipe.ingredientAmounts.removeAt(index);
                        RecipesService.of(context).update(recipe);
                      },
                    );
                  },
                ),
              ),
              StreamBuilder(
                stream: ConsumptionsService.of(context).forRecipe(recipe),
                builder: (context, snapshot) {
                  return SimpleCard(
                    title: "History",
                    child: ConsumptionsList(
                      snapshot.data ?? [],
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      elevation: 4,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class IngredientAmountListSurface extends StatelessWidget {
  final IngredientAmount ingredientAmount;
  final void Function(IngredientAmount value) onChange;
  final void Function() onDelete;

  const IngredientAmountListSurface(
    this.ingredientAmount, {
    super.key,
    required this.onChange,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ingredientAmount.ingredient,
      builder: (context, snapshot) {
        Ingredient? ingredient = snapshot.data;

        return ListSurface(
          elevation: 4,
          icon: (ingredient?.icon != null)
              ? Icons8Icon(ingredient!.icon!)
              : const CircularProgressIndicator(),
          title: ingredient?.name ?? '...',
          subtitle: '${ingredientAmount.amount.decimals(2).toString()} grams',
          onTap: () async {
            IngredientAmount edited = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CreateIngredientAmountView(
                  ingredientAmount: ingredientAmount,
                ),
              ),
            );

            onChange(edited);
          },
          actions: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (ingredient != null)
                WithConfirmationDialog(
                  title: ingredient.name,
                  description:
                      'Are you sure you want to remove this ingredient?',
                  builder: (context, confirm) => IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () async {
                      if (await confirm()) {
                        onDelete();
                      }
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
