import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:vim/models/consumption.dart';
import 'package:vim/models/ingredient_consumption.dart';
import 'package:vim/models/nutrition.dart';
import 'package:vim/models/performance.dart';
import 'package:vim/widgets/dialogs/quick_track_exercise_dialog.dart';
import 'package:vim/widgets/dialogs/quick_track_food_dialog.dart';
import 'package:vim/widgets/dialogs/track_ingredient_dialog.dart';

enum QuickTrack { food, exercise }

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DateTime _date = DateTime.now();

  List<Consumption> _consumptions = [];
  List<Performance> _performances = [];

  Consumption get _totalConsumption {
    return _consumptions.isNotEmpty
        ? _consumptions.reduce((total, entry) => Consumption(
              name: 'Total',
              nutrition: total.nutrition.add(entry.nutrition),
            ))
        : Consumption(
            name: 'Total',
            nutrition: Nutrition(calories: 0),
          );
  }

  Performance get _totalPerformance {
    return _performances.isNotEmpty
        ? _performances.reduce((total, entry) => Performance(
              name: 'Total',
              calories: total.calories + entry.calories,
            ))
        : Performance(
            name: 'Total',
            calories: 0,
          );
  }

  _DashboardState() {
    _initialize();
  }

  void _initialize() async {
    List<Consumption> consumptions = await Consumption.forDate(_date);
    List<IngredientConsumption> ingredientConsumptions =
        await IngredientConsumption.forDate(_date);
    List<Performance> performances = await Performance.forDate(_date);

    setState(() {
      _consumptions = [
        ...consumptions,
        ...ingredientConsumptions,
      ];
      _performances = performances;
    });
  }

  void _addConsumption(Consumption consumption) {
    setState(() {
      _consumptions = [..._consumptions, consumption];
    });

    consumption.save();
  }

  void _addPerformance(Performance performance) {
    setState(() {
      _performances = [..._performances, performance];
    });

    performance.save();
  }

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
                _addConsumption(consumption);
              }
            },
            child: const Icon(Icons.bakery_dining),
          ),
          SpeedDialChild(
            label: 'Quick Track Food',
            onTap: () async {
              Consumption? consumption = await _showQuickTrackFoodDialog(
                context: context,
              );

              if (consumption != null) {
                _addConsumption(consumption);
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
                _addPerformance(performance);
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
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${_totalConsumption.nutrition.calories.round()}',
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
                              '${_totalPerformance.calories.round()}',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            const Text('Burnt'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${_totalConsumption.nutrition.carbohydrates.round()}',
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
                              '${_totalConsumption.nutrition.fat.round()}',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            const Text('Fat'),
                          ],
                        ),
                        const SizedBox(width: 64),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${_totalConsumption.nutrition.protein.round()}',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            const Text('Protein'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _date = _date.subtract(const Duration(days: 1));
                              _initialize();
                            });
                          },
                          icon: const Icon(Icons.chevron_left),
                        ),
                        Text(
                          DateFormat.yMMMMd('en_US').format(_date),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _date = _date.add(const Duration(days: 1));
                              _initialize();
                            });
                          },
                          icon: const Icon(Icons.chevron_right),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Food',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _consumptions.length,
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          title: Text(_consumptions[index].name),
                          subtitle: Text(
                              '${_consumptions[index].nutrition.calories.round()} kcal'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () async {
                                  Consumption entry = _consumptions[index];

                                  if (entry is IngredientConsumption) {
                                    IngredientConsumption? consumption =
                                        await _showTrackIngredientDialog(
                                      context: context,
                                      ingredientConsumption: entry,
                                    );

                                    if (consumption != null) {
                                      consumption.save();

                                      setState(() {
                                        _consumptions[index] = consumption;
                                        _consumptions = [..._consumptions];
                                      });
                                    }
                                  } else {
                                    Consumption? consumption =
                                        await _showQuickTrackFoodDialog(
                                      context: context,
                                      consumption: _consumptions[index],
                                    );

                                    if (consumption != null) {
                                      consumption.save();

                                      setState(() {
                                        _consumptions[index] = consumption;
                                        _consumptions = [..._consumptions];
                                      });
                                    }
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _consumptions[index].delete();

                                  setState(() {
                                    _consumptions.removeAt(index);
                                    _consumptions = [..._consumptions];
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Exercise',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _performances.length,
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          title: Text(_performances[index].name),
                          subtitle:
                              Text('${_performances[index].calories} kcal'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () async {
                                  Performance? performance =
                                      await _showQuickTrackExerciseDialog(
                                    context: context,
                                    performance: _performances[index],
                                  );

                                  if (performance != null) {
                                    performance.save();

                                    setState(() {
                                      _performances[index] = performance;
                                      _performances = [..._performances];
                                    });
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _performances[index].delete();

                                  setState(() {
                                    _performances.removeAt(index);
                                    _performances = [..._performances];
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
}
