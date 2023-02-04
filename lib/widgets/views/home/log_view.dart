import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/performances.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/consumptions.dart';
import 'package:vim/models/food/ingredient_consumption.dart';
import 'package:vim/models/food/recipe_consumption.dart';
import 'package:vim/services/consumptions_service.dart';
import 'package:vim/services/performances_service.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/molecules/date_stepper.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';
import 'package:vim/widgets/views/home/log/consumption_view.dart';
import 'package:vim/widgets/views/home/log/create_consumption_view.dart';
import 'package:vim/widgets/views/home/log/create_exercise_performance_view.dart';
import 'package:vim/widgets/views/home/log/create_ingredient_consumption_view.dart';
import 'package:vim/widgets/views/home/log/create_performance_view.dart';
import 'package:vim/widgets/views/home/log/create_recipe_consumption_view.dart';

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
          child: DateStepper(),
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
                              icon: const Icon(Icons.dinner_dining),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateIngredientConsumptionView(),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.book),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateRecipeConsumptionView(),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.flash_on_rounded),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateConsumptionView(),
                                  ),
                                );
                              },
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
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.fitness_center),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateExercisePerformanceView(),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.flash_on_rounded),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CreatePerformanceView(),
                                  ),
                                );
                              },
                            ),
                          ],
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
            subtitle: SecondaryText(
              // TODO: Try to change this into Chip widgets.
              [
                if (consumption is RecipeConsumption) ...[
                  '${consumption.amount}',
                ],
                if (consumption is IngredientConsumption) ...[
                  '${consumption.amount}',
                ],
                '${consumption.nutrition.calories.round()} cal',
                [
                  '${consumption.nutrition.carbohydrates.total?.round() ?? 0}',
                  '${consumption.nutrition.proteins.total?.round() ?? 0}',
                  '${consumption.nutrition.fats.total?.round() ?? 0}',
                ].join("/")
              ].join(" • "),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      ConsumptionView(consumption: consumption),
                ),
              );
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                          builder: (context) => CreateConsumptionView(
                            consumption: consumption,
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
                        ConsumptionsService.delete(consumption);
                      }
                    },
                  ),
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
            subtitle: SecondaryText('${performance.calories.round()} kcal'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CreatePerformanceView(
                          performance: performance,
                        ),
                      ),
                    );
                  },
                ),
                WithConfirmationDialog(
                  title: performance.name,
                  description:
                      'Are you sure you want to delete this performance?',
                  builder: (context, confirm) => IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      if (await confirm()) {
                        PerformancesService.delete(performance);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
