import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/ingredients.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:vim/widgets/views/home/food/ingredients/create_ingredient_view.dart';
import 'package:vim/widgets/views/home/food/ingredients/ingredient_view.dart';

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
          builder: (context, ingredients, child) => StandardList(
            itemCount: ingredients.length,
            itemBuilder: (context, index) {
              Ingredient ingredient = ingredients.get(index);

              return IngredientListTile(
                ingredient: ingredient,
              );
            },
          ),
        ),
      ),
    );
  }
}

class IngredientListTile extends StatelessWidget {
  const IngredientListTile({
    super.key,
    required this.ingredient,
  });

  final Ingredient ingredient;

  @override
  Widget build(BuildContext context) {
    return ListSurface(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => IngredientView(ingredient: ingredient),
          ),
        );
      },
      icon: ingredient.icon != null ? Icons8Icon(ingredient.icon!) : null,
      title: Text(ingredient.name),
      subtitle: SecondaryText(ingredient.brand ?? "--"),
      // subtitle: SecondaryText(
      //   // TODO: Try to change this into Chip widgets.
      //   [
      //     if (ingredient.brand != null) ...[
      //       '${ingredient.brand}',
      //     ],
      //     '${ingredient.nutrition.calories.round()} cal',
      //     [
      //       '${ingredient.nutrition.carbohydrates.total?.round() ?? 0}',
      //       '${ingredient.nutrition.proteins.total?.round() ?? 0}',
      //       '${ingredient.nutrition.fats.total?.round() ?? 0}',
      //     ].join("/")
      //   ].join(" • "),
      // ),
    );
  }
}
