import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/consumptions.dart';
import 'package:vim/models/nutrition.dart';
import 'package:vim/models/performances.dart';
import 'package:vim/models/settings.dart';
import 'package:vim/widgets/molecules/date_stepper.dart';
import 'package:vim/widgets/vim.dart';

/// TODO: Move these to the user's account.
Settings settings = Settings(
  gender: Gender.male,
  age: 33,
  weight: 66.5,
  length: 176,
  muscle: 81.0,
  fat: 14.8,
  neat: 320, // a rough estimate
  surplus: 0.1,
  exercise: 400,
  carbohydrates: 0.45,
  proteins: 0.25,
  fats: 0.3,
);

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          Consumer<ThemeModel>(
            builder: (context, themeModel, _) => IconButton(
              icon: Icon(
                themeModel.mode == ThemeMode.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: () {
                themeModel.mode = themeModel.mode == ThemeMode.dark
                    ? ThemeMode.light
                    : ThemeMode.dark;
              },
            ),
          ),
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
              children: const [
                CaloriesCard(),
                MacrosCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CaloriesCard extends StatelessWidget {
  const CaloriesCard({super.key});

  @override
  Widget build(BuildContext context) {
    Consumptions consumptions = Provider.of<Consumptions>(context);
    Performances performances = Provider.of<Performances>(context);

    double adjustedIntake = settings.adjustedIntake(performances);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calories',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${consumptions.nutrition.calories.round()}',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            ' / ${adjustedIntake.round()}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 128,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3)),
                          child: LinearProgressIndicator(
                            value: consumptions.nutrition.calories /
                                adjustedIntake,
                            minHeight: 6,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text('Consumed'),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${performances.calories.round()}',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            ' / ${settings.exercise.round()}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 128,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3)),
                          child: LinearProgressIndicator(
                            value: performances.calories / settings.exercise,
                            minHeight: 6,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text('Burned'),
                    ],
                  ),
                ],
              ),
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
    Performances performances = Provider.of<Performances>(context);

    double adjustedIntake = settings.adjustedIntake(performances);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Macros',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${consumptions.nutrition.carbohydrates.total?.round() ?? 0}',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            ' / ${Carbohydrates.grams(adjustedIntake * settings.carbohydrates).round()}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 80,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2)),
                          child: LinearProgressIndicator(
                            value: (consumptions
                                        .nutrition.carbohydrates.total ??
                                    0) /
                                Carbohydrates.grams(
                                    adjustedIntake * settings.carbohydrates),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text('Carbs'),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${consumptions.nutrition.proteins.total?.round() ?? 0}',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            ' / ${Proteins.grams(adjustedIntake * settings.proteins).round()}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 80,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2)),
                          child: LinearProgressIndicator(
                            value:
                                (consumptions.nutrition.proteins.total ?? 0) /
                                    Proteins.grams(
                                        adjustedIntake * settings.proteins),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text('Protein'),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${consumptions.nutrition.fats.total?.round() ?? 0}',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            ' / ${Fats.grams(adjustedIntake * settings.fats).round()}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 80,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2)),
                          child: LinearProgressIndicator(
                            value: (consumptions.nutrition.fats.total ?? 0) /
                                Fats.grams(adjustedIntake * settings.fats),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text('Fat'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
