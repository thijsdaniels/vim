import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vim/extensions/num.dart';
import 'package:vim/models/food/amount.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/ingredient_consumption.dart';
import 'package:vim/models/food/recipe_consumption.dart';
import 'package:vim/services/consumptions_service.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/molecules/nutrition_table.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';
import 'package:vim/widgets/views/home/log/food_log/create_ingredient_consumption_view.dart';
import 'package:vim/widgets/views/home/log/food_log/create_quick_track_consumption_view.dart';
import 'package:vim/widgets/views/home/log/food_log/create_recipe_consumption_view.dart';

class ConsumptionView extends StatefulWidget {
  final Consumption consumption;

  const ConsumptionView({
    super.key,
    required this.consumption,
  });

  @override
  State<ConsumptionView> createState() => _ConsumptionViewState();
}

class _ConsumptionViewState extends State<ConsumptionView> {
  @override
  Widget build(BuildContext context) {
    Consumption consumption = widget.consumption;

    return Scaffold(
      appBar: AppBar(
        title: Text(consumption.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              if (consumption is RecipeConsumption) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateRecipeConsumptionView(
                      recipeConsumption: consumption,
                    ),
                  ),
                );
              } else if (consumption is IngredientConsumption) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateIngredientConsumptionView(
                      ingredientConsumption: consumption,
                    ),
                  ),
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateQuickTrackConsumptionView(
                      consumption: consumption,
                    ),
                  ),
                );
              }
            },
          ),
          WithConfirmationDialog(
            title: consumption.name,
            description: 'Are you sure you want to delete this consumption?',
            builder: (context, confirm) => IconButton(
              icon: const Icon(Icons.delete_rounded),
              onPressed: () async {
                if (await confirm()) {
                  ConsumptionsService.delete(consumption);

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
                      if (consumption is! IngredientConsumption &&
                          consumption is! RecipeConsumption)
                        TableRow(
                          children: [
                            const SecondaryText('Name'),
                            const SizedBox(width: 32),
                            Text(consumption.name),
                          ],
                        ),
                      if (consumption is IngredientConsumption) ...[
                        TableRow(
                          children: [
                            const SecondaryText('Ingredient'),
                            const SizedBox(width: 32),
                            Text(consumption.ingredient.name),
                          ],
                        ),
                        TableRow(
                          children: [
                            const SecondaryText('Brand'),
                            const SizedBox(width: 32),
                            consumption.ingredient.brand != null
                                ? Text(consumption.ingredient.brand!)
                                : const SecondaryText('--'),
                          ],
                        ),
                        TableRow(
                          children: [
                            const SecondaryText('Amount'),
                            const SizedBox(width: 32),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(consumption.amount.value.toString()),
                                    const SizedBox(width: 4),
                                    SecondaryText(
                                      describeEnum(consumption.amount.unit),
                                    ),
                                  ],
                                ),
                                if (consumption.amount.unit == Unit.servings)
                                  Row(
                                    children: [
                                      Text((consumption.amount.value *
                                              consumption.ingredient.serving!)
                                          .toString()),
                                      const SizedBox(width: 4),
                                      const SecondaryText('grams'),
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                      if (consumption is RecipeConsumption) ...[
                        TableRow(
                          children: [
                            const SecondaryText('Recipe'),
                            const SizedBox(width: 32),
                            Text(consumption.recipe.name),
                          ],
                        ),
                        TableRow(
                          children: [
                            const SecondaryText('Amount'),
                            const SizedBox(width: 32),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(consumption.amount.value.toString()),
                                    const SizedBox(width: 4),
                                    SecondaryText(
                                      describeEnum(consumption.amount.unit),
                                    ),
                                  ],
                                ),
                                if (consumption.amount.unit == Unit.servings)
                                  Row(
                                    children: [
                                      Text((consumption.amount.value *
                                              consumption.recipe
                                                  .ingredientAmounts.amount /
                                              consumption.recipe.servings)
                                          .toString()),
                                      const SizedBox(width: 4),
                                      const SecondaryText('grams'),
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              SimpleCard(
                title: 'Nutrition',
                child: Center(
                  child: NutritionTable(
                    nutrition: consumption.nutrition,
                  ),
                ),
              ),
              if (consumption is RecipeConsumption)
                SimpleCard(
                  title: 'Ingredients',
                  child: Center(
                    child: Table(
                      defaultColumnWidth: const IntrinsicColumnWidth(),
                      children: consumption.recipe.ingredientAmounts
                          .map(
                            (ingredientAmount) => TableRow(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(ingredientAmount.ingredient.name),
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
