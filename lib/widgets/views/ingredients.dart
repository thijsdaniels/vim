import 'package:flutter/material.dart';
import 'package:vim/models/ingredient.dart';
import 'package:vim/widgets/dialogs/create_ingredient_dialog.dart';

class Ingredients extends StatefulWidget {
  const Ingredients({super.key});

  @override
  State<Ingredients> createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {
  List<Ingredient> _ingredients = [];

  _IngredientsState() {
    _initialize();
  }

  void _initialize() async {
    List<Ingredient> ingredients = await Ingredient.all();

    setState(() {
      _ingredients = ingredients;
    });
  }

  void _addIngredient(Ingredient ingredient) {
    setState(() {
      _ingredients = [..._ingredients, ingredient];
    });

    ingredient.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Ingredient? ingredient = await _showCreateIngredientDialog(
            context: context,
          );

          if (ingredient != null) {
            _addIngredient(ingredient);
          }

          return;
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          itemCount: _ingredients.length,
          itemBuilder: (context, index) => Card(
            child: ListTile(
              title: Text(_ingredients[index].name),
              subtitle: Text(_ingredients[index].brand ?? ""),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      Ingredient? ingredient =
                          await _showCreateIngredientDialog(
                        context: context,
                        ingredient: _ingredients[index],
                      );

                      if (ingredient != null) {
                        ingredient.save();

                        setState(() {
                          _ingredients[index] = ingredient;
                          _ingredients = [..._ingredients];
                        });
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _ingredients[index].delete();

                      setState(() {
                        _ingredients.removeAt(index);
                        _ingredients = [..._ingredients];
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Ingredient?> _showCreateIngredientDialog({
    required BuildContext context,
    Ingredient? ingredient,
  }) {
    return showDialog<Ingredient>(
      context: context,
      builder: (BuildContext context) {
        return CreateIngredientDialog(
          ingredient: ingredient,
        );
      },
    );
  }
}
