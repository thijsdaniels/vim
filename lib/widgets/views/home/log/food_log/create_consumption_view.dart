import 'package:flutter/material.dart';
import 'package:vim/widgets/views/home/log/food_log/create_ingredient_consumption_view.dart';
import 'package:vim/widgets/views/home/log/food_log/create_quick_track_consumption_view.dart';
import 'package:vim/widgets/views/home/log/food_log/create_recipe_consumption_view.dart';

class CreateConsumptionView extends StatefulWidget {
  const CreateConsumptionView({super.key});

  @override
  State<CreateConsumptionView> createState() => _CreateConsumptionViewState();
}

class _CreateConsumptionViewState extends State<CreateConsumptionView> {
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
        bottomNavigationBar: TabBar(
          tabs: const [
            Tab(text: 'Ingredient'),
            Tab(text: 'Recipe'),
            Tab(text: 'Quick Track'),
          ],
          onTap: _onTap,
        ),
        body: [
          const CreateIngredientConsumptionView(),
          const CreateRecipeConsumptionView(),
          const CreateQuickTrackConsumptionView(),
        ][_selectedIndex],
      ),
    );
  }
}
