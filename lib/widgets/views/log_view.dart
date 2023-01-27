import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/consumption.dart';
import 'package:vim/models/consumptions.dart';
import 'package:vim/models/ingredient_consumption.dart';
import 'package:vim/models/performance.dart';
import 'package:vim/models/performances.dart';
import 'package:vim/models/recipe_consumption.dart';
import 'package:vim/services/consumptions_service.dart';
import 'package:vim/services/performances_service.dart';
import 'package:vim/widgets/date_picker.dart';
import 'package:vim/widgets/dialogs/quick_track_exercise_dialog.dart';
import 'package:vim/widgets/dialogs/quick_track_food_dialog.dart';
import 'package:vim/widgets/dialogs/track_ingredient_dialog.dart';
import 'package:vim/widgets/dialogs/track_recipe_dialog.dart';

class LogView extends StatelessWidget {
  const LogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: DatePicker(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Food',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => _trackIngredient(context),
                              icon: const Icon(Icons.dinner_dining),
                            ),
                            IconButton(
                              onPressed: () => _trackRecipe(context),
                              icon: const Icon(Icons.book),
                            ),
                            IconButton(
                              onPressed: () => _quickTrackFood(context),
                              icon: const Icon(Icons.flash_on_rounded),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const ConsumptionsList(),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Exercise',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        IconButton(
                          onPressed: () => _quickTrackExercise(context),
                          icon: const Icon(Icons.flash_on_rounded),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const PerformancesList(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _trackIngredient(BuildContext context) async {
    Consumption? consumption = await _showTrackIngredientDialog(context);

    if (consumption != null) {
      ConsumptionsService.create(consumption);
    }
  }

  Future<void> _trackRecipe(BuildContext context) async {
    Consumption? consumption = await _showTrackRecipeDialog(context);

    if (consumption != null) {
      ConsumptionsService.create(consumption);
    }
  }

  Future<void> _quickTrackFood(BuildContext context) async {
    Consumption? consumption = await _showQuickTrackFoodDialog(context);

    if (consumption != null) {
      ConsumptionsService.create(consumption);
    }
  }

  Future<void> _quickTrackExercise(BuildContext context) async {
    Performance? performance = await _showQuickTrackExerciseDialog(context);

    if (performance != null) {
      PerformancesService.create(performance);
    }
  }
}

Future<IngredientConsumption?> _showTrackIngredientDialog(
  BuildContext context, {
  IngredientConsumption? ingredientConsumption,
}) {
  return showDialog<IngredientConsumption>(
    context: context,
    builder: (BuildContext context) {
      return TrackIngredientDialog(
        ingredientConsumption: ingredientConsumption,
      );
    },
  );
}

Future<RecipeConsumption?> _showTrackRecipeDialog(
  BuildContext context, {
  RecipeConsumption? recipeConsumption,
}) {
  return showDialog<RecipeConsumption>(
    context: context,
    builder: (BuildContext context) {
      return TrackRecipeDialog(
        recipeConsumption: recipeConsumption,
      );
    },
  );
}

Future<Consumption?> _showQuickTrackFoodDialog(
  BuildContext context, {
  Consumption? consumption,
}) {
  return showDialog<Consumption>(
    context: context,
    builder: (BuildContext context) {
      return QuickTrackFoodDialog(
        consumption: consumption,
      );
    },
  );
}

Future<Performance?> _showQuickTrackExerciseDialog(
  BuildContext context, {
  Performance? performance,
}) {
  return showDialog<Performance>(
    context: context,
    builder: (BuildContext context) {
      return QuickTrackExerciseDialog(
        performance: performance,
      );
    },
  );
}

class ConsumptionsList extends StatelessWidget {
  const ConsumptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    Consumptions consumptions = Provider.of<Consumptions>(context);

    if (consumptions.length == 0) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Icon(
              Icons.more_horiz,
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.25),
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: consumptions.length,
      itemBuilder: (context, index) {
        Consumption consumption = consumptions.get(index);

        return Card(
          child: ListTile(
            title: Text(consumption.name),
            subtitle: Text(
              [
                if (consumption is RecipeConsumption) ...[
                  '${consumption.amount}',
                ],
                if (consumption is IngredientConsumption) ...[
                  '${consumption.amount} grams',
                ],
                '${consumption.nutrition.calories.round()} calories',
              ].join(" • "),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    if (consumption is RecipeConsumption) {
                      RecipeConsumption? edited = await _showTrackRecipeDialog(
                        context,
                        recipeConsumption: consumption,
                      );

                      if (edited != null) {
                        ConsumptionsService.update(edited);
                      }
                    } else if (consumption is IngredientConsumption) {
                      IngredientConsumption? edited =
                          await _showTrackIngredientDialog(
                        context,
                        ingredientConsumption: consumption,
                      );

                      if (edited != null) {
                        ConsumptionsService.update(edited);
                      }
                    } else {
                      Consumption? edited = await _showQuickTrackFoodDialog(
                        context,
                        consumption: consumption,
                      );

                      if (edited != null) {
                        ConsumptionsService.update(edited);
                      }
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    ConsumptionsService.delete(consumption);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PerformancesList extends StatelessWidget {
  const PerformancesList({super.key});

  @override
  Widget build(BuildContext context) {
    Performances performances = Provider.of<Performances>(context);

    if (performances.length == 0) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Icon(
              Icons.more_horiz,
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.25),
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: performances.length,
      itemBuilder: (context, index) {
        Performance performance = performances.get(index);

        return Card(
          child: ListTile(
            title: Text(performance.name),
            subtitle: Text('${performance.calories} kcal'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    Performance? edited = await _showQuickTrackExerciseDialog(
                      context,
                      performance: performance,
                    );

                    if (edited != null) {
                      PerformancesService.update(edited);
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    PerformancesService.delete(performance);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
