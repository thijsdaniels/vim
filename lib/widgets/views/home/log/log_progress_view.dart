import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/performances.dart';
import 'package:vim/models/food/consumptions.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/models/settings_model.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/nutrition_table.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/molecules/target_progress.dart';

class LogProgressView extends StatelessWidget {
  const LogProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    return const StandardList(
      spacing: 16,
      children: [
        CaloriesCard(),
        MacrosCard(),
        NutritionCard(),
      ],
    );
  }
}

class CaloriesCard extends StatelessWidget {
  const CaloriesCard({super.key});

  @override
  Widget build(BuildContext context) {
    Consumptions consumptions = Provider.of<Consumptions>(context);
    Performances performances = Provider.of<Performances>(context);

    return Consumer<SettingsModel>(
      builder: (context, settings, _) => SimpleCard(
        title: 'Calories',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FutureBuilder(
              future: settings.body.adjustedIntake(performances),
              builder: (context, snapshot) => TargetProgress(
                title: 'Consumed',
                progress: consumptions.nutrition.calories,
                target: snapshot.hasData ? snapshot.data! : null,
                barSize: TargetProgressBarSize.large,
              ),
            ),
            FutureBuilder(
              future: performances.calories,
              builder: (context, snapshot) => TargetProgress(
                title: 'Burned',
                progress: snapshot.data ?? 0,
                target: settings.body.exercise,
                barSize: TargetProgressBarSize.large,
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

    return Consumer<SettingsModel>(
      builder: (context, settings, _) => SimpleCard(
        title: 'Macros',
        child: FutureBuilder(
          future: settings.body.adjustedIntake(performances),
          builder: (context, snapshot) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TargetProgress(
                title: 'Carbs',
                progress: snapshot.hasData
                    ? consumptions.nutrition.carbohydrates.total ?? 0
                    : 0,
                target: snapshot.hasData
                    ? Carbohydrates.grams(
                        snapshot.data! * settings.body.carbohydrates,
                      )
                    : null,
              ),
              TargetProgress(
                title: 'Proteins',
                progress: snapshot.hasData
                    ? consumptions.nutrition.proteins.total ?? 0
                    : 0,
                target: snapshot.hasData
                    ? Proteins.grams(snapshot.data! * settings.body.proteins)
                    : null,
              ),
              TargetProgress(
                title: 'Fats',
                progress: snapshot.hasData
                    ? consumptions.nutrition.fats.total ?? 0
                    : 0,
                target: snapshot.hasData
                    ? Fats.grams(snapshot.data! * settings.body.fats)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NutritionCard extends StatelessWidget {
  const NutritionCard({super.key});

  @override
  Widget build(BuildContext context) {
    Consumptions consumptions = Provider.of<Consumptions>(context);

    return SimpleCard(
      title: 'Nutrition',
      child: Center(
        child: NutritionTable(
          nutrition: consumptions.nutrition,
        ),
      ),
    );
  }
}
