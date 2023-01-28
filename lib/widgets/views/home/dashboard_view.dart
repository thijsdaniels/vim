import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/consumptions.dart';
import 'package:vim/models/performances.dart';
import 'package:vim/widgets/molecules/date_stepper.dart';
import 'package:vim/widgets/vim.dart';

/// TODO: Get these targets from the user's settings.
const int targetDailyCalorieIntake = 2400;
const int targetDailyCalorieOutput = 500;

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
              child: Column(
                children: <Widget>[
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(children: [
                        const Text('Consumed'),
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          child: LinearProgressIndicator(
                            value: consumptions.nutrition.calories /
                                (targetDailyCalorieIntake +
                                    performances.calories),
                            minHeight: 8,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${consumptions.nutrition.calories.round()}',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        )
                      ]),
                      TableRow(
                        children: [
                          const Text('Burned'),
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            child: LinearProgressIndicator(
                              value: performances.calories /
                                  targetDailyCalorieOutput,
                              minHeight: 8,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${performances.calories.round()}',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ],
                      )
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${consumptions.nutrition.carbohydrates.total?.round() ?? 0}',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const Text('Carbs'),
                    ],
                  ),
                  const SizedBox(width: 64),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${consumptions.nutrition.proteins.total?.round() ?? 0}',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const Text('Protein'),
                    ],
                  ),
                  const SizedBox(width: 64),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${consumptions.nutrition.fats.total?.round() ?? 0}',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
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
