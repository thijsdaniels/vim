import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/performances.dart';
import 'package:vim/models/food/consumptions.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/models/settings.dart';
import 'package:vim/widgets/molecules/nutrition_table.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/molecules/target_progress.dart';

/// TODO: Move these to the user's account.
Settings settings = Settings(
  gender: Gender.male,
  age: 33,
  weight: 66.5,
  length: 176,
  muscle: 81.0,
  fat: 14.8,
  neat: 300, // a rough estimate
  surplus: -0.05,
  exercise: 400,
  carbohydrates: 0.45,
  proteins: 0.25,
  fats: 0.3,
);

class LogProgressView extends StatelessWidget {
  const LogProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: const [
              CaloriesCard(),
              SizedBox(height: 12),
              MacrosCard(),
              SizedBox(height: 12),
              NutritionCard(),
            ],
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

    return SimpleCard(
      title: 'Calories',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FutureBuilder(
            future: settings.adjustedIntake(performances),
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
              target: settings.exercise,
              barSize: TargetProgressBarSize.large,
            ),
          ),
        ],
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

    return SimpleCard(
      title: 'Macros',
      child: FutureBuilder(
        future: settings.adjustedIntake(performances),
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
                      snapshot.data! * settings.carbohydrates,
                    )
                  : null,
            ),
            TargetProgress(
              title: 'Proteins',
              progress: snapshot.hasData
                  ? consumptions.nutrition.proteins.total ?? 0
                  : 0,
              target: snapshot.hasData
                  ? Proteins.grams(snapshot.data! * settings.proteins)
                  : null,
            ),
            TargetProgress(
              title: 'Fats',
              progress:
                  snapshot.hasData ? consumptions.nutrition.fats.total ?? 0 : 0,
              target: snapshot.hasData
                  ? Fats.grams(snapshot.data! * settings.fats)
                  : null,
            ),
          ],
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
