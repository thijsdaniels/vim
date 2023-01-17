import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'consumption.dart';
import 'performance.dart';
import 'quick_track.dart';

enum QuickTrack { food, exercise }

class Dashboard extends StatefulWidget {
  const Dashboard({ super.key });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DateTime _date = DateTime.now();

  List<Consumption> _consumptions = [];
  List<Performance> _performances = [];

  _DashboardState() {
    _initialize();
  }

  _initialize() async {
    List<Consumption> consumptions = await Consumption.forDate(_date);
    List<Performance> performances = await Performance.forDate(_date);

    setState(() {
      _consumptions = consumptions;
      _performances = performances;
    });
  }

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
      body: SingleChildScrollView(
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
                            '${_totalConsumption.calories}',
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
                            '${_totalPerformance.calories}',
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
                            '${_totalConsumption.carbohydrates}',
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
                            '${_totalConsumption.fat}',
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
                            '${_totalConsumption.protein}',
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
                        subtitle: Text('${_consumptions[index].calories} kcal'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _consumptions[index].delete();

                            setState(() {
                              _consumptions.removeAt(index);
                              _consumptions = [..._consumptions];
                            });
                          },
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
                        subtitle: Text('${_performances[index].calories} kcal'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _performances[index].delete();

                            setState(() {
                              _performances.removeAt(index);
                              _performances = [..._performances];
                            });
                          },
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
