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
        NutritionRow('Energy', nutrition?.calories, unit: 'kcal'),
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
        NutritionRow('Water', nutrition?.water),
        NutritionRow('Alcohol', nutrition?.alcohol),
        NutritionRow('Stimulants', null, unit: null),
        NutritionRow(
          'Caffeine',
          nutrition?.stimulants.caffeine != null
              ? nutrition!.stimulants.caffeine! * 1000
              : null,
          unit: "mg",
          indented: true,
        ),
        NutritionRow(
          'Creatine',
          nutrition?.stimulants.creatine != null
              ? nutrition!.stimulants.creatine! * 1000
              : null,
          unit: "mg",
          indented: true,
        ),
        NutritionRow('Minerals', null, unit: null),
        NutritionRow(
          'Boron',
          nutrition?.minerals.boron != null
              ? nutrition!.minerals.boron! * 1000000
              : null,
          unit: "µg",
          indented: true,
        ),
        NutritionRow(
          'Calcium',
          nutrition?.minerals.calcium != null
              ? nutrition!.minerals.calcium! * 1000
              : null,
          unit: "mg",
          indented: true,
        ),
        NutritionRow(
          'Chromium',
          nutrition?.minerals.chromium != null
              ? nutrition!.minerals.chromium! * 1000000
              : null,
          unit: "µg",
          indented: true,
        ),
        NutritionRow(
          'Cobalt',
          nutrition?.minerals.cobalt != null
              ? nutrition!.minerals.cobalt! * 1000000
              : null,
          unit: "µg",
          indented: true,
        ),
        NutritionRow(
          'Copper',
          nutrition?.minerals.copper != null
              ? nutrition!.minerals.copper! * 1000000
              : null,
          unit: "µg",
          indented: true,
        ),
        NutritionRow(
          'Fluoride',
          nutrition?.minerals.fluoride != null
              ? nutrition!.minerals.fluoride! * 1000000
              : null,
          unit: "µg",
          indented: true,
        ),
        NutritionRow(
          'Iodine',
          nutrition?.minerals.iodine != null
              ? nutrition!.minerals.iodine! * 1000000
              : null,
          unit: "µg",
          indented: true,
        ),
        NutritionRow(
          'Iron',
          nutrition?.minerals.iron != null
              ? nutrition!.minerals.iron! * 1000000
              : null,
          unit: "µg",
          indented: true,
        ),
        NutritionRow(
          'Magnesium',
          nutrition?.minerals.magnesium != null
              ? nutrition!.minerals.magnesium! * 1000
              : null,
          unit: "mg",
          indented: true,
        ),
        NutritionRow(
          'Manganese',
          nutrition?.minerals.manganese != null
              ? nutrition!.minerals.manganese! * 1000000
              : null,
          unit: "µg",
          indented: true,
        ),
        NutritionRow(
          'Molybdenum',
          nutrition?.minerals.molybdenum != null
              ? nutrition!.minerals.molybdenum! * 1000000
              : null,
          unit: "µg",
          indented: true,
        ),
        NutritionRow(
          'Phosphorus',
          nutrition?.minerals.phosphorus != null
              ? nutrition!.minerals.phosphorus! * 1000
              : null,
          unit: "mg",
          indented: true,
        ),
        NutritionRow(
          'Potassium',
          nutrition?.minerals.potassium != null
              ? nutrition!.minerals.potassium! * 1000
              : null,
          unit: "mg",
          indented: true,
        ),
        NutritionRow(
          'Selenium',
          nutrition?.minerals.selenium != null
              ? nutrition!.minerals.selenium! * 1000000
              : null,
          unit: "µg",
          indented: true,
        ),
        NutritionRow(
          'Sodium',
          nutrition?.minerals.sodium != null
              ? nutrition!.minerals.sodium! * 1000
              : null,
          unit: "mg",
          indented: true,
        ),
        NutritionRow(
          'Zinc',
          nutrition?.minerals.zinc != null
              ? nutrition!.minerals.zinc! * 1000000
              : null,
          unit: "µg",
          indented: true,
        ),
        NutritionRow('Vitamins', null, unit: null),
        NutritionRow(
          'Vitamin A',
          nutrition?.vitamins.a != null
              ? nutrition!.vitamins.a! * 1000000
              : null,
          unit: "µg",
          indented: true,
        ),
        NutritionRow(
          'Vitamin B1',
          nutrition?.vitamins.b1 != null
              ? nutrition!.vitamins.b1! * 1000
              : null,
          unit: "mg",
          indented: true,
        ),
        NutritionRow(
          'Vitamin B2',
          nutrition?.vitamins.b2 != null
              ? nutrition!.vitamins.b2! * 1000
              : null,
          unit: "mg",
          indented: true,
        ),
        NutritionRow(
          'Vitamin B3',
          nutrition?.vitamins.b3 != null
              ? nutrition!.vitamins.b3! * 1000
              : null,
          unit: "mg",
          indented: true,
        ),
        NutritionRow(
          'Vitamin B5',
          nutrition?.vitamins.b5 != null
              ? nutrition!.vitamins.b5! * 1000
              : null,
          unit: "mg",
          indented: true,
        ),
        NutritionRow(
          'Vitamin B6',
          nutrition?.vitamins.b6 != null
              ? nutrition!.vitamins.b6! * 1000
              : null,
          unit: "mg",
          indented: true,
        ),
        NutritionRow(
          'Vitamin B7',
          nutrition?.vitamins.b7 != null
              ? nutrition!.vitamins.b7! * 1000000
              : null,
          unit: "µg",
          indented: true,
        ),
        NutritionRow(
          'Vitamin B9',
          nutrition?.vitamins.b9 != null
              ? nutrition!.vitamins.b9! * 1000
              : null,
          unit: "mg",
          indented: true,
        ),
        NutritionRow(
          'Vitamin B12',
          nutrition?.vitamins.b12 != null
              ? nutrition!.vitamins.b12! * 1000000
              : null,
          unit: "µg",
          indented: true,
        ),
        NutritionRow(
          'Vitamin C',
          nutrition?.vitamins.c != null ? nutrition!.vitamins.c! * 1000 : null,
          unit: "mg",
          indented: true,
        ),
        NutritionRow(
          'Vitamin D',
          nutrition?.vitamins.d != null
              ? nutrition!.vitamins.d! * 1000000
              : null,
          unit: "µg",
          indented: true,
        ),
        NutritionRow(
          'Vitamin E',
          nutrition?.vitamins.e != null ? nutrition!.vitamins.e! * 1000 : null,
          unit: "mg",
          indented: true,
        ),
        NutritionRow(
          'Vitamin K',
          nutrition?.vitamins.k != null
              ? nutrition!.vitamins.k! * 1000000
              : null,
          unit: "µg",
          indented: true,
        ),
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
          amount?.decimals(2).toString(),
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
      Text(value ?? (unit != null ? '--' : ''), textAlign: TextAlign.end),
      const SizedBox(width: 4),
      SecondaryText(unit ?? ''),
    ];
  }
}
