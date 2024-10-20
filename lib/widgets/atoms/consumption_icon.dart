import 'package:flutter/material.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/ingredient_consumption.dart';
import 'package:vim/models/food/recipe_consumption.dart';
import 'package:vim/widgets/atoms/ingredient_consumption_icon.dart';
import 'package:vim/widgets/atoms/recipe_consumption_icon.dart';

class ConsumptionIcon extends StatelessWidget {
  final double elevation;
  final Consumption consumption;

  const ConsumptionIcon(
    this.consumption, {
    super.key,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    if (consumption is IngredientConsumption) {
      return IngredientConsumptionIcon(consumption as IngredientConsumption);
    }

    if (consumption is RecipeConsumption) {
      return RecipeConsumptionIcon(consumption as RecipeConsumption);
    }

    return Container();
  }
}
