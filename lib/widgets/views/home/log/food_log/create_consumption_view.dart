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
        appBar: AppBar(
          title: const Text('Track Food'),
          bottom: TabBar(
            tabs: const [
              Tab(
                icon: Icon(Icons.dinner_dining),
                text: 'Ingredient',
              ),
              Tab(
                icon: Icon(Icons.book),
                text: 'Recipe',
              ),
              Tab(
                icon: Icon(Icons.flash_on_rounded),
                text: 'Quick Track',
              ),
            ],
            onTap: _onTap,
          ),
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
