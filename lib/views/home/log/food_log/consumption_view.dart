import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vim/extensions/date_time.dart';
import 'package:vim/extensions/ingredient_amounts.dart';
import 'package:vim/models/food/amount.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/ingredient_consumption.dart';
import 'package:vim/models/food/quick_consumption.dart';
import 'package:vim/models/food/recipe_consumption.dart';
import 'package:vim/services/consumptions_collection_group.dart';
import 'package:vim/services/consumptions_collection.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/atoms/stats_table.dart';
import 'package:vim/widgets/molecules/consumptions_list.dart';
import 'package:vim/widgets/molecules/nutrition_table.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';
import 'package:vim/views/home/log/food_log/create_ingredient_consumption_view.dart';
import 'package:vim/views/home/log/food_log/create_quick_track_consumption_view.dart';
import 'package:vim/views/home/log/food_log/create_recipe_consumption_view.dart';
import 'package:vim/views/loading_view.dart';
import 'package:vim/views/not_found_view.dart';

class ConsumptionView extends StatefulWidget {
  final String path;

  const ConsumptionView({
    super.key,
    required this.path,
  });

  @override
  State<ConsumptionView> createState() => _ConsumptionViewState();
}

class _ConsumptionViewState extends State<ConsumptionView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Consumption?>(
      stream: ConsumptionsCollectionGroup.instance.get(widget.path),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingView();
        }

        if (!snapshot.hasData) {
          return const NotFoundView();
        }

        Consumption consumption = snapshot.requireData!;

        /// TODO: There _must_ be a better way to do this than hardcoding what
        /// the expected path is... Right?
        bool isReadOnly =
            consumption.reference!.parent.parent?.parent.id != 'users';

        return Scaffold(
          appBar: AppBar(
            title: Text(consumption.name),
            actions: isReadOnly
                ? null
                : [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        if (consumption is QuickConsumption) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  CreateQuickTrackConsumptionView(
                                consumption: consumption,
                              ),
                            ),
                          );
                        } else if (consumption is IngredientConsumption) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  CreateIngredientConsumptionView(
                                ingredientConsumption: consumption,
                              ),
                            ),
                          );
                        } else if (consumption is RecipeConsumption) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CreateRecipeConsumptionView(
                                recipeConsumption: consumption,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    WithConfirmationDialog(
                      title: consumption.name,
                      description:
                          'Are you sure you want to delete this consumption?',
                      builder: (context, confirm) => IconButton(
                        icon: const Icon(Icons.delete_rounded),
                        onPressed: () async {
                          if (await confirm()) {
                            ConsumptionsCollection.of(context)
                                .delete(consumption);

                            if (mounted) {
                              Navigator.of(context).pop();
                            }
                          }
                        },
                      ),
                    ),
                  ],
          ),

          /// TODO: Split this body into three separate widgets, one for each of
          /// the types of consumption. All these `if` statements I'm using are
          /// making this body very difficult to read.
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
                      StatsRow(
                          'Ingredient', consumption.ingredient.snapshot.name),
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
                      StatsRow('Recipe', consumption.recipe.snapshot.name),
                      StatsRow(
                        'Amount',
                        consumption.amount.value.toString(),
                        unit: describeEnum(consumption.amount.unit),
                      ),
                      if (consumption.amount.unit == Unit.servings)
                        StatsRow(
                          '',
                          (consumption.amount.value *
                                  consumption.recipe.snapshot.ingredientAmounts
                                      .amount /
                                  consumption.recipe.snapshot.servings)
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
                  child: FutureBuilder(
                    future: Future.value(consumption.nutrition),
                    builder: (context, snapshot) => NutritionTable(
                      nutrition: snapshot.data,
                    ),
                  ),
                ),
              ),
              if (consumption is RecipeConsumption)
                SimpleCard(
                  title: 'Ingredients',
                  child: StreamBuilder(
                    stream: consumption.consumptions,
                    builder: (context, consumptionsSnapshot) {
                      return ConsumptionsList(
                        consumptionsSnapshot.data ?? [],
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        elevation: 4,
                        showCalories: false,
                        showMacros: false,
                        showTime: false,
                      );
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
