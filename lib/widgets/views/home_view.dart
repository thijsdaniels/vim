import 'package:flutter/material.dart';
import 'package:vim/widgets/views/dashboard_view.dart';
import 'package:vim/widgets/views/ingredients_view.dart';
import 'package:vim/widgets/views/log_view.dart';
import 'package:vim/widgets/views/recipes_view.dart';

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
      body: <Widget>[
        const DashboardView(),
        const LogView(),
        const IngredientsView(),
        const RecipesView(),
      ][_selectedIndex],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt),
            label: 'Log',
          ),
          NavigationDestination(
            icon: Icon(Icons.dinner_dining),
            label: 'Food',
          ),
          NavigationDestination(
            icon: Icon(Icons.book),
            label: 'Recipes',
          ),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
    );
  }
}
