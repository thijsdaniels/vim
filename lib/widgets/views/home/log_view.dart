import 'package:flutter/material.dart';
import 'package:vim/widgets/molecules/date_stepper.dart';
import 'package:vim/widgets/views/home/dashboard_view.dart';
import 'package:vim/widgets/views/home/log/exercise_log_view.dart';
import 'package:vim/widgets/views/home/log/food_log_view.dart';

class LogView extends StatefulWidget {
  const LogView({super.key});

  @override
  State<LogView> createState() => _LogViewState();
}

class _LogViewState extends State<LogView> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Log'),
          bottom: TabBar(
            tabs: const [
              Tab(
                icon: Icon(Icons.dashboard),
                text: 'Overview',
              ),
              Tab(
                icon: Icon(Icons.lunch_dining),
                text: 'Food',
              ),
              Tab(
                icon: Icon(Icons.fitness_center),
                text: 'Exercise',
              ),
            ],
            onTap: _onTap,
          ),
        ),
        body: [
          const DashboardView(),
          const FoodLogView(),
          const ExerciseLogView(),
        ][_selectedIndex],
        bottomNavigationBar: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
          ),
          child: const DateStepper(),
        ),
      ),
    );
  }
}
