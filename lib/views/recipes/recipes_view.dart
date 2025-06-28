import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/widgets/atoms/floating_action_surface.dart';
import 'package:vim/widgets/molecules/app_drawer.dart';
import 'package:vim/widgets/molecules/recipes_list.dart';

class RecipesView extends StatelessWidget {
  const RecipesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Consumer<List<Recipe>>(
          builder: (context, recipes, child) => RecipesList(
            recipes,
            searchable: true,
          ),
        ),
      ),
      floatingActionButton: FloatingActionSurface(
        onPressed: () {
          final user = User.of(context);
          context.push('/users/${user.reference!.id}/recipes/create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
