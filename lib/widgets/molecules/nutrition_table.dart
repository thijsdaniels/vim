import 'package:flutter/material.dart';
import 'package:vim/extensions/num.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/atoms/stats_table.dart';

class NutritionTable extends StatelessWidget {
  final Nutrition? nutrition;

  const NutritionTable({super.key, required this.nutrition});

  @override
  Widget build(BuildContext context) {
    return StatsTable(
      children: [
        NutritionRow('Calories', nutrition?.calories, unit: 'kcal'),
        NutritionRow('Fats', nutrition?.fats.total),
        NutritionRow(
          'Saturated Fats',
          nutrition?.fats.saturates,
          indented: true,
        ),
        NutritionRow('Carbohydrates', nutrition?.carbohydrates.total),
        NutritionRow('Sugars', nutrition?.carbohydrates.sugars, indented: true),
        NutritionRow('Fibers', nutrition?.carbohydrates.fibers, indented: true),
        NutritionRow('Proteins', nutrition?.proteins.total),
        NutritionRow('Minerals', null),
        NutritionRow('Calcium', nutrition?.minerals.calcium, indented: true),
        NutritionRow('Sodium', nutrition?.minerals.sodium, indented: true),
        NutritionRow('Vitamins', null),
        NutritionRow('A', nutrition?.vitamins.a, indented: true),
        NutritionRow('B1', nutrition?.vitamins.b1, indented: true),
        NutritionRow('B2', nutrition?.vitamins.b2, indented: true),
        NutritionRow('Water', nutrition?.water),
        NutritionRow('Alcohol', nutrition?.alcohol),
        NutritionRow('Caffeine', nutrition?.caffeine),
      ],
    );
  }
}

class NutritionRow extends StatsRow {
  NutritionRow(
    String label,
    num? amount, {
    super.key,
    super.unit = 'g',
    this.indented = false,
  }) : super(
          label,
          (amount ?? 0).decimals(2).toString(),
        );

  final bool indented;

  @override
  get children {
    return [
      Row(
        children: [
          if (indented) const SizedBox(width: 16),
          SecondaryText(label),
        ],
      ),
      const SizedBox(width: 32),
      Text(value!, textAlign: TextAlign.end),
      const SizedBox(width: 4),
      SecondaryText(unit!),
    ];
  }
}
