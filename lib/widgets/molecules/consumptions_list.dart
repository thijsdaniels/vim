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
                  consumption.ingredient.snapshot.icon != null
              ? Icons8Icon(consumption.ingredient.snapshot.icon!)
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
          title: consumption.name,
          // TODO: Try to change this into Chip widgets.
          subtitle: [
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
        );
      },
    );
  }
}
