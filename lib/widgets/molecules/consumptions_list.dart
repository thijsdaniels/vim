import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/consumptions.dart';
import 'package:vim/models/food/ingredient_consumption.dart';
import 'package:vim/models/food/recipe_consumption.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';
import 'package:vim/widgets/atoms/icons8_icons_stack.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/atoms/surface_list.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:vim/widgets/views/home/log/food_log/consumption_view.dart';

// TODO: Receive `consumptions` as a parameter instead of taking them from
// context, so that this widget can also be used with a particular set of
// consumptions other than the main one.
class ConsumptionsList extends StatelessWidget {
  const ConsumptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    Consumptions consumptions = Provider.of<Consumptions>(context);

    if (consumptions.length == 0) {
      return Center(
        child: Icon(
          Icons.more_horiz,
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.25),
        ),
      );
    }

    return SurfaceList(
      itemCount: consumptions.length,
      itemBuilder: (context, index) {
        Consumption consumption = consumptions.get(index);

        return ListSurface(
          icon: consumption is IngredientConsumption &&
                  consumption.ingredient.icon != null
              ? Icons8Icon.asset(consumption.ingredient.icon!, size: 48)
              : consumption is RecipeConsumption
                  ? Icons8IconStack(
                      icons: consumption.recipe.ingredientAmounts
                          .map(
                            (ingredientAmount) =>
                                ingredientAmount.ingredient.icon,
                          )
                          .toList(),
                    )
                  : null,
          title: Text(consumption.name),
          // TODO: Try to change this into Chip widgets.
          subtitle: SecondaryText(
            [
              if (consumption is RecipeConsumption) ...[
                '${consumption.amount}',
              ],
              if (consumption is IngredientConsumption) ...[
                '${consumption.amount}',
              ],
              '${consumption.nutrition.calories.round()} cal',
              [
                '${consumption.nutrition.carbohydrates.total?.round() ?? 0}',
                '${consumption.nutrition.proteins.total?.round() ?? 0}',
                '${consumption.nutrition.fats.total?.round() ?? 0}',
              ].join("/")
            ].join(" • "),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ConsumptionView(consumption: consumption),
              ),
            );
          },
          // trailing: Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     IconButton(
          //       icon: const Icon(Icons.edit),
          //       onPressed: () async {
          //         if (consumption is RecipeConsumption) {
          //           Navigator.of(context).push(
          //             MaterialPageRoute(
          //               builder: (context) => CreateRecipeConsumptionView(
          //                 recipeConsumption: consumption,
          //               ),
          //             ),
          //           );
          //         } else if (consumption is IngredientConsumption) {
          //           Navigator.of(context).push(
          //             MaterialPageRoute(
          //               builder: (context) => CreateIngredientConsumptionView(
          //                 ingredientConsumption: consumption,
          //               ),
          //             ),
          //           );
          //         } else {
          //           Navigator.of(context).push(
          //             MaterialPageRoute(
          //               builder: (context) => CreateConsumptionView(
          //                 consumption: consumption,
          //               ),
          //             ),
          //           );
          //         }
          //       },
          //     ),
          //     WithConfirmationDialog(
          //       title: consumption.name,
          //       description:
          //           'Are you sure you want to delete this consumption?',
          //       builder: (context, confirm) => IconButton(
          //         icon: const Icon(Icons.delete_rounded),
          //         onPressed: () async {
          //           if (await confirm()) {
          //             ConsumptionsService.delete(consumption);
          //           }
          //         },
          //       ),
          //     ),
          //   ],
          // ),
        );
      },
    );
  }
}
