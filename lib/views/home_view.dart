import 'package:flutter/material.dart';
import 'package:vim/views/home/exercise_view.dart';
import 'package:vim/views/home/food_view.dart';
import 'package:vim/views/home/friends_view.dart';
import 'package:vim/views/home/log_view.dart';

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
        const FriendsView(),
      ][_selectedIndex],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.book),
            label: 'Log',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant),
            label: 'Food',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center),
            label: 'Exercise',
          ),
          NavigationDestination(
            icon: Icon(Icons.people),
            label: 'Friends',
          ),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
    );
  }
}
