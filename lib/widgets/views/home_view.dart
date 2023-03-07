import 'package:flutter/material.dart';
import 'package:vim/widgets/views/home/exercise_view.dart';
import 'package:vim/widgets/views/home/food_view.dart';
import 'package:vim/widgets/views/home/log_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const LogView(),
        const FoodView(),
        const ExerciseView(),
      ][_selectedIndex],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.receipt_outlined),
            selectedIcon: Icon(Icons.receipt),
            label: 'Log',
          ),
          NavigationDestination(
            icon: Icon(Icons.lunch_dining_outlined),
            selectedIcon: Icon(Icons.lunch_dining_rounded),
            label: 'Foods',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center_outlined),
            selectedIcon: Icon(Icons.fitness_center),
            label: 'Exercises',
          ),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
    );
  }
}
