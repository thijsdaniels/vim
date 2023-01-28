import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/ingredient.dart';
import 'package:vim/models/ingredients.dart';
import 'package:vim/services/ingredients_service.dart';
import 'package:vim/widgets/views/home/ingredients/create_ingredient_view.dart';
import 'package:vim/widgets/atoms/subtitle.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';

class IngredientsView extends StatefulWidget {
  const IngredientsView({super.key});

  @override
  State<IngredientsView> createState() => _IngredientsViewState();
}

class _IngredientsViewState extends State<IngredientsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort_rounded),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_alt_rounded),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
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
                  subtitle: (ingredient.brand != null)
                      ? Subtitle(ingredient.brand!)
                      : null,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (ingredient.nutrition.isComplete())
                        const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.check_rounded),
                        ),
                      IconButton(
                        icon: const Icon(Icons.edit_rounded),
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CreateIngredientView(
                                ingredient: ingredient,
                              ),
                            ),
                          );
                        },
                      ),
                      WithConfirmationDialog(
                        title: ingredient.name,
                        description:
                            'Are you sure you want to delete this ingredient?',
                        builder: (context, confirm) => IconButton(
                          icon: const Icon(Icons.delete_rounded),
                          onPressed: () async {
                            if (await confirm()) {
                              IngredientsService.delete(ingredient);
                            }
                          },
                        ),
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
}
