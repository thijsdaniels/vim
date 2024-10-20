import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/widgets/atoms/floating_action_surface.dart';
import 'package:vim/widgets/molecules/app_drawer.dart';
import 'package:vim/widgets/molecules/ingredients_list.dart';
import 'package:vim/views/ingredients/create_ingredient_view.dart';

class IngredientsView extends StatelessWidget {
  const IngredientsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingredients'),
      ),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionSurface(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateIngredientView(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Consumer<List<Ingredient>>(
          builder: (context, ingredients, child) => IngredientsList(
            ingredients,
            searchable: true,
          ),
        ),
      ),
    );
  }
}
