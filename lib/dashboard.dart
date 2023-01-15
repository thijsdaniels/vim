import 'package:flutter/material.dart';
import 'package:vim/quick_track.dart';

enum QuickTrack { food, exercise }

class Dashboard extends StatefulWidget {
  const Dashboard({ super.key });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class Consumption {
  String name;
  int calories;
  int carbohydrates;
  int fat;
  int protein;

  Consumption({
    required this.name,
    required this.calories,
    this.carbohydrates = 0,
    this.fat = 0,
    this.protein = 0,
  });
}

class Performance {
  String name;
  int calories;

  Performance({
    required this.name,
    required this.calories,
  });
}

class _DashboardState extends State<Dashboard> {
  List<Consumption> _consumptions = [];
  List<Performance> _performances = [];

  Consumption get _totalConsumption {
    return _consumptions.isNotEmpty
      ? _consumptions.reduce((total, entry) => Consumption(
          name: 'Total',
          calories: total.calories + entry.calories,
          carbohydrates: total.carbohydrates + entry.carbohydrates,
          fat: total.fat + entry.fat,
          protein: total.protein + entry.protein,
        ))
      : Consumption(
          name: 'Total',
          calories: 0,
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

  int get _caloricBalance {
    return _totalConsumption.calories - _totalPerformance.calories;
  }

  void _addConsumption(Consumption consumption) {
    setState(() {
      _consumptions = [..._consumptions, consumption];
    });
  }

  void _addPerformance(Performance performance) {
    setState(() {
      _performances = [..._performances, performance];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: <Widget>[
          PopupMenuButton<QuickTrack>(
            icon: const Icon(Icons.flash_on_rounded),
            tooltip: 'Quick Track',
            itemBuilder: (BuildContext context) => <PopupMenuEntry<QuickTrack>>[
              const PopupMenuItem(
                value: QuickTrack.food,
                child: Text('Food'),
              ),
              const PopupMenuItem(
                value: QuickTrack.exercise,
                child: Text('Exercise'),
              ),
            ],
            onSelected: (value) async {
              switch (value) {
                case QuickTrack.food:
                  Consumption? consumption = await _showQuickTrackFoodDialog(context);

                  if (consumption != null) {
                    _addConsumption(consumption);
                  }

                  return;
                case QuickTrack.exercise:
                  Performance? performance = await _showQuickTrackExerciseDialog(context);

                  if (performance != null) {
                    _addPerformance(performance);
                  }

                  return;
              }
            },
          ),
        ]
      ),
      body: Column(
        children: [
          Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Text('Balance'),
                  Text(
                    '$_caloricBalance',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Consumed'),
                      Text(
                        '${_totalConsumption.calories}',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                  const SizedBox(width: 32),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Burnt'),
                      Text(
                        '${_totalPerformance.calories}',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Carbs'),
                      Text(
                        '${_totalConsumption.carbohydrates}',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                  const SizedBox(width: 32),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Fat'),
                      Text(
                        '${_totalConsumption.fat}',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                  const SizedBox(width: 32),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Protein'),
                      Text(
                        '${_totalConsumption.protein}',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 64),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text('Food'),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _consumptions.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(_consumptions[index].name),
                  subtitle: Text('${_consumptions[index].calories} kcal'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _consumptions.removeAt(index);
                        _consumptions = [..._consumptions];
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text('Exercise'),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _performances.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(_performances[index].name),
                  subtitle: Text('${_performances[index].calories} kcal'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _performances.removeAt(index);
                        _performances = [..._performances];
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<Consumption?> _showQuickTrackFoodDialog(BuildContext context) {
    return showDialog<Consumption>(
      context: context,
      builder: (BuildContext context) {
        return const QuickTrackFoodDialog();
      },
    );
  }

  Future<Performance?> _showQuickTrackExerciseDialog(BuildContext context) {
    return showDialog<Performance>(
      context: context,
      builder: (BuildContext context) {
        return const QuickTrackExerciseDialog();
      },
    );
  }
}
