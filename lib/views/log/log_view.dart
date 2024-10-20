import 'package:flutter/material.dart';
import 'package:vim/views/log/log_consumptions_view.dart';
import 'package:vim/views/log/log_performances_view.dart';
import 'package:vim/views/log/log_progress_view.dart';
import 'package:vim/widgets/atoms/surface.dart';
import 'package:vim/widgets/molecules/app_drawer.dart';
import 'package:vim/widgets/molecules/date_stepper.dart';

class LogView extends StatefulWidget {
  const LogView({super.key});

  @override
  State<LogView> createState() => _LogViewState();
}

class _LogViewState extends State<LogView> {
  int _selectedIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log'),
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        child: [
          LogProgressView(),
          LogConsumptionsView(),
          LogPerformancesView(),
        ][_selectedIndex],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Surface(
            isPrimary: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: DateStepper(),
            ),
          ),
          NavigationBar(
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.book),
                label: 'Overview',
              ),
              NavigationDestination(
                icon: Icon(Icons.restaurant),
                label: 'Consumption',
              ),
              NavigationDestination(
                icon: Icon(Icons.fitness_center),
                label: 'Performance',
              ),
            ],
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onDestinationSelected,
          ),
        ],
      ),
    );
  }
}
