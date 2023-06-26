import 'package:flutter/material.dart';
import 'package:vim/extensions/date_time.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/ingredient_consumption.dart';
import 'package:vim/models/food/recipe_consumption.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';
import 'package:vim/widgets/atoms/icons8_icons_stack.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:vim/widgets/views/home/log/food_log/consumption_view.dart';

class ConsumptionsList extends StatelessWidget {
  const ConsumptionsList({
    super.key,
    required this.consumptions,
    this.physics,
    this.padding = const EdgeInsets.all(16.0),
    this.elevation,
  });

  final List<Consumption> consumptions;
  final ScrollPhysics? physics;
  final EdgeInsets padding;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    if (consumptions.isEmpty) {
      return Center(
        child: Icon(
          Icons.more_horiz,
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.25),
        ),
      );
    }

    return StandardList(
      physics: physics,
      padding: padding,
      itemCount: consumptions.length,
      itemBuilder: (context, index) {
        Consumption consumption = consumptions[index];

        return ListSurface(
          elevation: elevation,
          icon: consumption is IngredientConsumption &&
                  consumption.ingredient.icon != null
              ? Icons8Icon(consumption.ingredient.icon!)
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
          title: Text(consumption.name, overflow: TextOverflow.ellipsis),
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
          actions: SecondaryText(
            consumption.timestamp.toDate().toTimeString(),
          ),
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
