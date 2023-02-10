import 'package:flutter/material.dart';
import 'package:vim/widgets/views/home/food/ingredients_view.dart';
import 'package:vim/widgets/views/home/food/recipes_view.dart';

class FoodView extends StatefulWidget {
  const FoodView({super.key});

  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Food'),
          bottom: TabBar(
            tabs: const [
              Tab(
                icon: Icon(Icons.lunch_dining),
                text: 'Products',
              ),
              Tab(
                icon: Icon(Icons.book),
                text: 'Recipes',
              ),
            ],
            onTap: _onTap,
          ),
        ),
        body: [
          const IngredientsView(),
          const RecipesView(),
        ][_selectedIndex],
      ),
    );
  }
}
