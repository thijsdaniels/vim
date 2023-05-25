import 'package:flutter/material.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/services/ingredients_service.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/nutrition_table.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';
import 'package:vim/widgets/views/home/food/ingredients/create_ingredient_view.dart';
import 'package:vim/widgets/views/loading_view.dart';
import 'package:vim/widgets/views/not_found_view.dart';

class IngredientView extends StatelessWidget {
  final String ingredientId;

  const IngredientView(
    this.ingredientId, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Ingredient?>(
      stream: IngredientsService.instance.get(ingredientId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingView();
        }

        if (!snapshot.hasData) {
          return const NotFoundView();
        }

        Ingredient ingredient = snapshot.requireData!;

        return Scaffold(
          appBar: AppBar(
            title: Text(ingredient.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_rounded),
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CreateIngredientView(
                        ingredient: ingredient,
                      ),
                    ),
                  );
                },
              ),
              WithConfirmationDialog(
                title: ingredient.name,
                description: 'Are you sure you want to delete this ingredient?',
                builder: (context, confirm) => IconButton(
                  icon: const Icon(Icons.delete_rounded),
                  onPressed: () async {
                    var navigator = Navigator.of(context);
                    if (await confirm()) {
                      IngredientsService.instance.delete(ingredient);
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
                child: Center(
                  child: Table(
                    defaultColumnWidth: const IntrinsicColumnWidth(),
                    children: [
                      TableRow(
                        children: [
                          const SecondaryText('Name'),
                          const SizedBox(width: 32),
                          Text(ingredient.name),
                        ],
                      ),
                      TableRow(
                        children: [
                          const SecondaryText('Brand'),
                          const SizedBox(width: 32),
                          ingredient.brand != null
                              ? Text(ingredient.brand!)
                              : const SecondaryText('--'),
                        ],
                      ),
                      TableRow(
                        children: [
                          const SecondaryText('Serving'),
                          const SizedBox(width: 32),
                          ingredient.serving != null
                              ? Row(
                                  children: [
                                    Text(ingredient.serving.toString()),
                                    const SizedBox(width: 4),
                                    const SecondaryText('g'),
                                  ],
                                )
                              : const SecondaryText('--'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              /// TODO: Add a switch to allow the user to see the `Nutrition` for
              /// 100g even if the ingredient's data contains the `Nutrition` per
              /// serving, and vice versa.
              SimpleCard(
                title: 'Nutrition',
                actions: [
                  Text(
                    ingredient.nutritionPerServing ? '1 Serving' : '100 Grams',
                  )
                ],
                child: Center(
                  child: NutritionTable(
                    nutrition: ingredient.nutrition,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
