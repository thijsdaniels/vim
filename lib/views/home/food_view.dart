import 'package:flutter/material.dart';
import 'package:vim/views/home/food/ingredients_view.dart';
import 'package:vim/views/home/food/recipes_view.dart';

class FoodView extends StatelessWidget {
  const FoodView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Food'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Products'),
              Tab(text: 'Recipes'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            IngredientsView(),
            RecipesView(),
          ],
        ),
      ),
    );
  }
}
