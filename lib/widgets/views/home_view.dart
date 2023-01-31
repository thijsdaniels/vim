import 'package:flutter/material.dart';
import 'package:vim/widgets/views/home/dashboard_view.dart';
import 'package:vim/widgets/views/home/ingredients_view.dart';
import 'package:vim/widgets/views/home/log_view.dart';
import 'package:vim/widgets/views/home/recipes_view.dart';

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
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_outlined),
            selectedIcon: Icon(Icons.receipt),
            label: 'Log',
          ),
          NavigationDestination(
            icon: Icon(Icons.lunch_dining_outlined),
            selectedIcon: Icon(Icons.lunch_dining_rounded),
            label: 'Food',
          ),
          NavigationDestination(
            icon: Icon(Icons.book_outlined),
            selectedIcon: Icon(Icons.book_rounded),
            label: 'Recipes',
          ),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
    );
  }
}
