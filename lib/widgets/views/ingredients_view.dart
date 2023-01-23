import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/ingredient.dart';
import 'package:vim/models/ingredients.dart';
import 'package:vim/services/ingredients_service.dart';
import 'package:vim/widgets/dialogs/create_ingredient_dialog.dart';

class IngredientsView extends StatefulWidget {
  const IngredientsView({super.key});

  @override
  State<IngredientsView> createState() => _IngredientsViewState();
}

class _IngredientsViewState extends State<IngredientsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Ingredient? ingredient = await _showCreateIngredientDialog(
            context: context,
          );

          if (ingredient != null) {
            IngredientsService.create(ingredient);
          }

          return;
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Consumer<Ingredients>(
          builder: (context, ingredients, child) => ListView.builder(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            itemCount: ingredients.length,
            itemBuilder: (context, index) {
              Ingredient ingredient = ingredients.get(index);

              return Card(
                child: ListTile(
                  title: Text(ingredient.name),
                  subtitle: Text(ingredient.brand ?? ""),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          Ingredient? edited =
                              await _showCreateIngredientDialog(
                            context: context,
                            ingredient: ingredient,
                          );

                          if (edited != null) {
                            IngredientsService.update(edited);
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          IngredientsService.delete(ingredient);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
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
