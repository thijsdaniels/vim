import 'package:flutter/material.dart';
import 'package:vim/models/food/ingredient_consumption.dart';
import 'package:vim/widgets/atoms/food_icon.dart';

class IngredientConsumptionIcon extends StatelessWidget {
  final double elevation;
  final IngredientConsumption consumption;

  const IngredientConsumptionIcon(
    this.consumption, {
    super.key,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return consumption.ingredient.snapshot.icon != null
        ? FoodIcon(consumption.ingredient.snapshot.icon!)
        : Container();
  }
}
