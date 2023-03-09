import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/performances.dart';
import 'package:vim/models/food/consumptions.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/models/settings.dart';
import 'package:vim/widgets/molecules/date_stepper.dart';
import 'package:vim/widgets/molecules/nutrition_table.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/vim.dart';

/// TODO: Move these to the user's account.
Settings settings = Settings(
  gender: Gender.male,
  age: 33,
  weight: 66.5,
  length: 176,
  muscle: 81.0,
  fat: 14.8,
  neat: 600, // a rough estimate
  surplus: 0.1,
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
              MacrosCard(),
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
            title: 'Protein',
            progress: consumptions.nutrition.proteins.total ?? 0,
            target: Proteins.grams(adjustedIntake * settings.proteins),
          ),
          TargetProgress(
            title: 'Fat',
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

enum TargetProgressBarSize {
  small,
  large,
}

class TargetProgress extends StatelessWidget {
  const TargetProgress({
    super.key,
    required this.title,
    required this.target,
    required this.progress,
    this.barSize = TargetProgressBarSize.small,
  });

  final String title;
  final num target;
  final num progress;
  final TargetProgressBarSize barSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              progress.round().toString(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              ' / ${target.round().toString()}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: barSize == TargetProgressBarSize.small ? 80 : 128,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(barSize == TargetProgressBarSize.small ? 2 : 3),
            ),
            child: LinearProgressIndicator(
              value: progress / target,
              minHeight: barSize == TargetProgressBarSize.small ? 4 : 6,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(title),
      ],
    );
  }
}
