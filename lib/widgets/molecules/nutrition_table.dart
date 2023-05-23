import 'package:flutter/material.dart';
import 'package:vim/extensions/num.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';

class NutritionTable extends StatelessWidget {
  final Nutrition nutrition;

  const NutritionTable({super.key, required this.nutrition});

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      children: [
        NutritionRow(
          context: context,
          label: 'Calories',
          amount: nutrition.calories,
          unit: 'kcal',
        ),
        NutritionRow(
          context: context,
          label: 'Fats',
          amount: nutrition.fats.total,
        ),
        NutritionRow(
          context: context,
          label: 'Saturated Fats',
          amount: nutrition.fats.saturates,
          indented: true,
        ),
        NutritionRow(
          context: context,
          label: 'Carbohydrates',
          amount: nutrition.carbohydrates.total,
        ),
        NutritionRow(
          context: context,
          label: 'Sugars',
          amount: nutrition.carbohydrates.sugars,
          indented: true,
        ),
        NutritionRow(
          context: context,
          label: 'Fibers',
          amount: nutrition.carbohydrates.fibers,
          indented: true,
        ),
        NutritionRow(
          context: context,
          label: 'Proteins',
          amount: nutrition.proteins.total,
        ),
        NutritionRow(
          context: context,
          label: 'Salt',
          amount: nutrition.minerals.salt,
        ),
      ],
    );
  }
}

class NutritionRow extends TableRow {
  final String label;
  final num? amount;
  final BuildContext context;
  final String unit;
  final bool indented;

  const NutritionRow({
    super.key,
    required this.context,
    required this.label,
    required this.amount,
    this.unit = 'g',
    this.indented = false,
  });

  @override
  get children {
    return [
      Row(
        children: [
          if (indented) const SizedBox(width: 16),
          Text(label),
        ],
      ),
      const SizedBox(width: 32),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (amount == null) const SecondaryText('--'),
          if (amount != null) ...[
            Text(amount!.decimals(2).toString()),
            const SizedBox(width: 4),
            SecondaryText(unit),
          ],
        ],
      ),
    ];
  }
}
