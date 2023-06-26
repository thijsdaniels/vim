import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/extensions/consumptions_list.dart';
import 'package:vim/extensions/performances_list.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/models/user/user.dart';
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
    List<Consumption> consumptions = Provider.of<List<Consumption>>(context);
    List<Performance> performances = Provider.of<List<Performance>>(context);

    return Consumer<User?>(
      builder: (context, user, _) => SimpleCard(
        title: 'Calories',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FutureBuilder(
              future: user?.targetConsumption(performances),
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
                target: user?.target.performance.calories,
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
    List<Consumption> consumptions = Provider.of<List<Consumption>>(context);
    List<Performance> performances = Provider.of<List<Performance>>(context);

    return Consumer<User?>(
      builder: (context, user, _) => SimpleCard(
        title: 'Macros',
        child: FutureBuilder(
          future: user?.targetConsumption(performances),
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
                        snapshot.data! *
                            (user?.targetCarbohydrateConsumption ?? 0),
                      )
                    : null,
              ),
              TargetProgress(
                title: 'Proteins',
                progress: snapshot.hasData
                    ? consumptions.nutrition.proteins.total ?? 0
                    : 0,
                target: snapshot.hasData
                    ? Proteins.grams(
                        snapshot.data! * (user?.targetProteinConsumption ?? 0),
                      )
                    : null,
              ),
              TargetProgress(
                title: 'Fats',
                progress: snapshot.hasData
                    ? consumptions.nutrition.fats.total ?? 0
                    : 0,
                target: snapshot.hasData
                    ? Fats.grams(
                        snapshot.data! * (user?.targetFatConsumption ?? 0))
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
    List<Consumption> consumptions = Provider.of<List<Consumption>>(context);

    return SimpleCard(
      title: 'Nutrition',
      child: NutritionTable(
        nutrition: consumptions.nutrition,
      ),
    );
  }
}
