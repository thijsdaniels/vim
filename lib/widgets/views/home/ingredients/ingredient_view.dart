import 'package:flutter/material.dart';
import 'package:vim/models/ingredient.dart';
import 'package:vim/models/nutrition.dart';
import 'package:vim/services/ingredients_service.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/molecules/nutrition_table.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';
import 'package:vim/widgets/views/home/ingredients/create_ingredient_view.dart';

class IngredientView extends StatefulWidget {
  final Ingredient ingredient;

  const IngredientView({
    super.key,
    required this.ingredient,
  });

  @override
  State<IngredientView> createState() => _IngredientViewState();
}

class _IngredientViewState extends State<IngredientView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ingredient.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_rounded),
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateIngredientView(
                    ingredient: widget.ingredient,
                  ),
                ),
              );
            },
          ),
          WithConfirmationDialog(
            title: widget.ingredient.name,
            description: 'Are you sure you want to delete this ingredient?',
            builder: (context, confirm) => IconButton(
              icon: const Icon(Icons.delete_rounded),
              onPressed: () async {
                if (await confirm()) {
                  IngredientsService.delete(widget.ingredient);

                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SimpleCard(
                title: 'Details',
                child: Center(
                  child: Table(
                    defaultColumnWidth: const IntrinsicColumnWidth(),
                    children: [
                      TableRow(
                        children: [
                          const SecondaryText('Name'),
                          const SizedBox(width: 32),
                          Text(widget.ingredient.name),
                        ],
                      ),
                      TableRow(
                        children: [
                          const SecondaryText('Brand'),
                          const SizedBox(width: 32),
                          widget.ingredient.brand != null
                              ? Text(widget.ingredient.brand!)
                              : const SecondaryText('--'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SimpleCard(
                title: 'Nutrition',
                child: Center(
                  child: NutritionTable(
                    nutrition: widget.ingredient.nutrition,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
