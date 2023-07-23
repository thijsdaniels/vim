import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/extensions/consumptions.dart';
import 'package:vim/extensions/performances.dart';
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
              future: user?.adjustedTargetConsumption(performances),
              builder: (context, targetSnapshot) => FutureBuilder(
                future: Future.value(consumptions.nutrition),
                builder: (context, nutritionSnapshot) => TargetProgress(
                  title: 'Consumed',
                  progress: nutritionSnapshot.data?.calories ?? 0,
                  target: targetSnapshot.data,
                  barSize: TargetProgressBarSize.large,
                ),
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
          future: Future.value(consumptions.nutrition),
          builder: (context, nutritionSnapshot) => FutureBuilder(
            future: user?.adjustedTargetConsumption(performances),
            builder: (context, targetSnapshot) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TargetProgress(
                  title: 'Carbs',
                  progress: targetSnapshot.hasData
                      ? nutritionSnapshot.data?.carbohydrates.total ?? 0
                      : 0,
                  target: targetSnapshot.hasData
                      ? Carbohydrates.grams(
                          targetSnapshot.data! *
                              (user?.targetCarbohydrateConsumption ?? 0),
                        )
                      : null,
                ),
                TargetProgress(
                  title: 'Proteins',
                  progress: targetSnapshot.hasData
                      ? nutritionSnapshot.data?.proteins.total ?? 0
                      : 0,
                  target: targetSnapshot.hasData
                      ? Proteins.grams(
                          targetSnapshot.data! *
                              (user?.targetProteinConsumption ?? 0),
                        )
                      : null,
                ),
                TargetProgress(
                  title: 'Fats',
                  progress: targetSnapshot.hasData
                      ? nutritionSnapshot.data?.fats.total ?? 0
                      : 0,
                  target: targetSnapshot.hasData
                      ? Fats.grams(targetSnapshot.data! *
                          (user?.targetFatConsumption ?? 0))
                      : null,
                ),
              ],
            ),
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
      child: Center(
        child: FutureBuilder(
          future: Future.value(consumptions.nutrition),
          builder: (context, snapshot) => NutritionTable(
            nutrition: snapshot.data,
          ),
        ),
      ),
    );
  }
}
