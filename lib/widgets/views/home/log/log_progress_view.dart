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

    double adjustedIntake = settings.adjustedIntake(performances);

    return SimpleCard(
      title: 'Calories',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TargetProgress(
            title: 'Consumed',
            progress: consumptions.nutrition.calories,
            target: adjustedIntake,
            barSize: TargetProgressBarSize.large,
          ),
          TargetProgress(
            title: 'Burned',
            progress: performances.calories,
            target: settings.exercise,
            barSize: TargetProgressBarSize.large,
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

    double adjustedIntake = settings.adjustedIntake(performances);

    return SimpleCard(
      title: 'Macros',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TargetProgress(
            title: 'Carbs',
            progress: consumptions.nutrition.carbohydrates.total ?? 0,
            target: Carbohydrates.grams(
              adjustedIntake * settings.carbohydrates,
            ),
          ),
          TargetProgress(
            title: 'Proteins',
            progress: consumptions.nutrition.proteins.total ?? 0,
            target: Proteins.grams(adjustedIntake * settings.proteins),
          ),
          TargetProgress(
            title: 'Fats',
            progress: consumptions.nutrition.fats.total ?? 0,
            target: Fats.grams(adjustedIntake * settings.fats),
          ),
        ],
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
