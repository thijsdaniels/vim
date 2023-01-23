import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/consumption.dart';
import 'package:vim/models/consumptions.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/ingredient_consumption.dart';
import 'package:vim/models/performance.dart';
import 'package:vim/models/performances.dart';
import 'package:vim/models/recipe_consumption.dart';
import 'package:vim/services/consumptions_service.dart';
import 'package:vim/services/performances_service.dart';
import 'package:vim/widgets/dialogs/quick_track_exercise_dialog.dart';
import 'package:vim/widgets/dialogs/quick_track_food_dialog.dart';
import 'package:vim/widgets/dialogs/track_ingredient_dialog.dart';
import 'package:vim/widgets/dialogs/track_recipe_dialog.dart';

enum QuickTrack { food, exercise }

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        children: [
          SpeedDialChild(
            label: 'Track Ingredient',
            onTap: () async {
              Consumption? consumption = await _showTrackIngredientDialog(
                context: context,
              );

              if (consumption != null) {
                ConsumptionsService.create(consumption);
              }
            },
            child: const Icon(Icons.bakery_dining),
          ),
          SpeedDialChild(
            label: 'Track Recipe',
            onTap: () async {
              Consumption? consumption = await _showTrackRecipeDialog(
                context: context,
              );

              if (consumption != null) {
                ConsumptionsService.create(consumption);
              }
            },
            child: const Icon(Icons.ramen_dining),
          ),
          SpeedDialChild(
            label: 'Quick Track Food',
            onTap: () async {
              Consumption? consumption = await _showQuickTrackFoodDialog(
                context: context,
              );

              if (consumption != null) {
                ConsumptionsService.create(consumption);
              }
            },
            child: Badge(
              badgeColor: Colors.white,
              animationDuration: Duration.zero,
              badgeContent: const Icon(Icons.flash_on_rounded, size: 16),
              position: BadgePosition.bottomEnd(bottom: -14, end: -14),
              padding: const EdgeInsets.all(2),
              child: const Icon(Icons.ramen_dining),
            ),
          ),
          SpeedDialChild(
            label: 'Quick Track Exercise',
            onTap: () async {
              Performance? performance = await _showQuickTrackExerciseDialog(
                context: context,
              );

              if (performance != null) {
                PerformancesService.create(performance);
              }
            },
            child: Badge(
              badgeColor: Colors.white,
              animationDuration: Duration.zero,
              badgeContent: const Icon(Icons.flash_on_rounded, size: 16),
              position: BadgePosition.bottomEnd(bottom: -14, end: -14),
              padding: const EdgeInsets.all(2),
              child: const Icon(Icons.fitness_center),
            ),
          ),
        ],
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        spacing: 16,
        spaceBetweenChildren: 16,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const CaloriesCard(),
                const MacrosCard(),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const DatePicker(),
                    const SizedBox(height: 32),
                    Text(
                      'Food',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    const ConsumptionsList(),
                    const SizedBox(height: 32),
                    Text(
                      'Exercise',
                      style: Theme.of(context).textTheme.titleLarge,
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
}

Future<IngredientConsumption?> _showTrackIngredientDialog({
  required BuildContext context,
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

Future<RecipeConsumption?> _showTrackRecipeDialog({
  required BuildContext context,
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

Future<Consumption?> _showQuickTrackFoodDialog({
  required BuildContext context,
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

Future<Performance?> _showQuickTrackExerciseDialog({
  required BuildContext context,
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

class CaloriesCard extends StatelessWidget {
  const CaloriesCard({super.key});

  @override
  Widget build(BuildContext context) {
    Consumptions consumptions = Provider.of<Consumptions>(context);
    Performances performances = Provider.of<Performances>(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${consumptions.nutrition.calories.round()}',
                  style: Theme.of(context).textTheme.headline3,
                ),
                const Text('Consumed'),
              ],
            ),
            const SizedBox(width: 64),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${performances.calories.round()}',
                  style: Theme.of(context).textTheme.headline3,
                ),
                const Text('Burnt'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MacrosCard extends StatelessWidget {
  const MacrosCard({super.key});

  @override
  Widget build(BuildContext context) {
    Consumptions consumptions = Provider.of<Consumptions>(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${consumptions.nutrition.carbohydrates.round()}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const Text('Carbs'),
              ],
            ),
            const SizedBox(width: 64),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${consumptions.nutrition.protein.round()}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const Text('Protein'),
              ],
            ),
            const SizedBox(width: 64),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${consumptions.nutrition.fat.round()}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const Text('Fat'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DatePicker extends StatelessWidget {
  const DatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    DateModel dateModel = Provider.of<DateModel>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          onPressed: dateModel.previous,
          icon: const Icon(Icons.chevron_left),
        ),
        Text(
          DateFormat.yMMMMd('en_US').format(dateModel.date),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        IconButton(
          onPressed: dateModel.next,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}

class ConsumptionsList extends StatelessWidget {
  const ConsumptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    Consumptions consumptions = Provider.of<Consumptions>(context);

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
                  'Thijs Daniels',
                  '${consumption.amount / consumption.recipe.ingredientAmounts.amount} serving${consumption.amount / consumption.recipe.ingredientAmounts.amount != 1 ? 's' : ''}',
                ],
                if (consumption is IngredientConsumption) ...[
                  if (consumption.ingredient.brand != null)
                    '${consumption.ingredient.brand}',
                  '${consumption.amount} gram${consumption.amount != 1 ? 's' : ''}',
                ],
                '${consumption.nutrition.calories.round()} kcal',
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
                        context: context,
                        recipeConsumption: consumption,
                      );

                      if (edited != null) {
                        ConsumptionsService.update(edited);
                      }
                    } else if (consumption is IngredientConsumption) {
                      IngredientConsumption? edited =
                          await _showTrackIngredientDialog(
                        context: context,
                        ingredientConsumption: consumption,
                      );

                      if (edited != null) {
                        ConsumptionsService.update(edited);
                      }
                    } else {
                      Consumption? edited = await _showQuickTrackFoodDialog(
                        context: context,
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
                      context: context,
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
