import 'package:flutter/material.dart';
import 'package:vim/extensions/date_time.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/ingredient_consumption.dart';
import 'package:vim/models/food/recipe_consumption.dart';
import 'package:vim/widgets/atoms/consumption_icon.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:vim/views/log/food_log/consumption_view.dart';

class ConsumptionListSurface extends StatelessWidget {
  final Consumption consumption;
  final double? elevation;
  final bool showCalories;
  final bool showMacros;
  final bool showTime;

  const ConsumptionListSurface(
    this.consumption, {
    super.key,
    this.elevation,
    this.showCalories = true,
    this.showMacros = true,
    this.showTime = true,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.value(consumption.nutrition),
      builder: (context, nutritionSnapshot) => ListSurface(
        elevation: elevation,
        icon: ConsumptionIcon(consumption),
        title: consumption.name,
        // TODO: Try to change this into Chip widgets.
        subtitle: [
          if (consumption is RecipeConsumption) ...[
            '${(consumption as RecipeConsumption).amount}',
          ],
          if (consumption is IngredientConsumption) ...[
            '${(consumption as IngredientConsumption).amount}',
          ],
          if (showCalories) '${nutritionSnapshot.data?.calories?.round()} cal',
          if (showMacros)
            [
              '${nutritionSnapshot.data?.carbohydrates.total?.round() ?? 0}',
              '${nutritionSnapshot.data?.proteins.total?.round() ?? 0}',
              '${nutritionSnapshot.data?.fats.total?.round() ?? 0}',
            ].join("/")
        ].join(" • "),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return ConsumptionView(path: consumption.reference!.path);
            }),
          );
        },
        trailing: showTime
            ? SecondaryText(
                consumption.timestamp.toDate().toTimeString(),
              )
            : null,
      ),
    );
  }
}
