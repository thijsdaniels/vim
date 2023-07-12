import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vim/extensions/date_time.dart';
import 'package:vim/extensions/num.dart';
import 'package:vim/models/food/amount.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/ingredient_consumption.dart';
import 'package:vim/models/food/recipe_consumption.dart';
import 'package:vim/services/consumptions_service.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/atoms/stats_table.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
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
                  ConsumptionsService.of(context).delete(consumption);

                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
            ),
          ),
        ],
      ),

      /// TODO: Split this body into three separate widgets, one for each of the
      /// types of consumption. All these `if` statements I'm using are making
      /// this body very difficult to read.
      body: StandardList(
        children: [
          SimpleCard(
            title: 'Details',
            child: StatsTable(
              children: [
                if (consumption is! IngredientConsumption &&
                    consumption is! RecipeConsumption)
                  StatsRow('Name', consumption.name),
                if (consumption is IngredientConsumption) ...[
                  StatsRow('Ingredient', consumption.ingredient.snapshot.name),
                  StatsRow('Brand', consumption.ingredient.snapshot.brand),
                  StatsRow(
                    'Amount',
                    consumption.amount.value.toString(),
                    unit: describeEnum(consumption.amount.unit),
                  ),
                  if (consumption.amount.unit == Unit.servings)
                    StatsRow(
                      '',
                      (consumption.amount.value *
                              consumption.ingredient.snapshot.serving!)
                          .toString(),
                      unit: 'grams',
                    ),
                ],
                if (consumption is RecipeConsumption) ...[
                  StatsRow('Recipe', consumption.recipe.name),
                  StatsRow(
                    'Amount',
                    consumption.amount.value.toString(),
                    unit: describeEnum(consumption.amount.unit),
                  ),
                  if (consumption.amount.unit == Unit.servings)
                    StatsRow(
                      '',
                      (consumption.amount.value *
                              consumption.recipe.ingredientAmounts.amount /
                              consumption.recipe.servings)
                          .toString(),
                      unit: 'grams',
                    ),
                ],
                StatsRow(
                  'Consumed At',
                  consumption.timestamp.toDate().toDateTimeString(),
                ),
              ],
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
              child: StandardList(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                children: consumption.ingredientAmounts
                    .map(
                      (ingredientAmount) => ListSurface(
                        elevation: 4,
                        icon: ingredientAmount.ingredient.icon != null
                            ? Icons8Icon(ingredientAmount.ingredient.icon!)
                            : null,
                        title: ingredientAmount.ingredient.name,
                        subtitle:
                            '${ingredientAmount.amount.decimals(2).toString()} grams',
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
