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
        ...energy(),
        ...fats(),
        ...carbohydrates(),
        ...proteins(),
        ...liquids(),
        ...stimulants(),
        ...minerals(),
        ...vitamins(),
      ],
    );
  }

  List<NutritionRow> energy() {
    return [
      NutritionRow('Energy', nutrition?.calories, unit: 'kcal'),
    ];
  }

  List<NutritionRow> fats() {
    return [
      NutritionRow('Fats', nutrition?.fats.total),
      NutritionRow(
        'Saturated Fats',
        nutrition?.fats.saturates,
        indented: true,
      ),
    ];
  }

  List<NutritionRow> proteins() {
    return [
      NutritionRow('Proteins', nutrition?.proteins.total),
    ];
  }

  List<NutritionRow> carbohydrates() {
    return [
      NutritionRow('Carbohydrates', nutrition?.carbohydrates.total),
      NutritionRow('Sugars', nutrition?.carbohydrates.sugars, indented: true),
      if (nutrition?.carbohydrates.fibers != null)
        NutritionRow('Fibers', nutrition?.carbohydrates.fibers, indented: true),
    ];
  }

  List<NutritionRow> liquids() {
    var rows = [
      if (nutrition?.water != null)
        NutritionRow('Water', nutrition?.water, indented: true),
      if (nutrition?.alcohol != null)
        NutritionRow('Alcohol', nutrition?.alcohol, indented: true),
    ];

    if (rows.isNotEmpty) {
      rows.insert(0, NutritionRow('Liquids', null, unit: null));
    }

    return rows;
  }

  List<NutritionRow> stimulants() {
    var rows = [
      if (nutrition?.stimulants.caffeine != null)
        NutritionRow(
          'Caffeine',
          nutrition!.stimulants.caffeine! * 1000,
          unit: "mg",
          indented: true,
        ),
      if (nutrition?.stimulants.creatine != null)
        NutritionRow(
          'Creatine',
          nutrition!.stimulants.creatine! * 1000,
          unit: "mg",
          indented: true,
        ),
    ];

    if (rows.isNotEmpty) {
      rows.insert(0, NutritionRow('Stimulants', null, unit: null));
    }

    return rows;
  }

  List<NutritionRow> minerals() {
    var rows = [
      if (nutrition?.minerals.boron != null)
        NutritionRow(
          'Boron',
          nutrition!.minerals.boron! * 1000000,
          unit: "µg",
          indented: true,
        ),
      if (nutrition?.minerals.calcium != null)
        NutritionRow(
          'Calcium',
          nutrition!.minerals.calcium! * 1000,
          unit: "mg",
          indented: true,
        ),
      if (nutrition?.minerals.chromium != null)
        NutritionRow(
          'Chromium',
          nutrition!.minerals.chromium! * 1000000,
          unit: "µg",
          indented: true,
        ),
      if (nutrition?.minerals.cobalt != null)
        NutritionRow(
          'Cobalt',
          nutrition!.minerals.cobalt! * 1000000,
          unit: "µg",
          indented: true,
        ),
      if (nutrition?.minerals.copper != null)
        NutritionRow(
          'Copper',
          nutrition!.minerals.copper! * 1000000,
          unit: "µg",
          indented: true,
        ),
      if (nutrition?.minerals.fluoride != null)
        NutritionRow(
          'Fluoride',
          nutrition!.minerals.fluoride! * 1000000,
          unit: "µg",
          indented: true,
        ),
      if (nutrition?.minerals.iodine != null)
        NutritionRow(
          'Iodine',
          nutrition!.minerals.iodine! * 1000000,
          unit: "µg",
          indented: true,
        ),
      if (nutrition?.minerals.iron != null)
        NutritionRow(
          'Iron',
          nutrition!.minerals.iron! * 1000000,
          unit: "µg",
          indented: true,
        ),
      if (nutrition?.minerals.magnesium != null)
        NutritionRow(
          'Magnesium',
          nutrition!.minerals.magnesium! * 1000,
          unit: "mg",
          indented: true,
        ),
      if (nutrition?.minerals.manganese != null)
        NutritionRow(
          'Manganese',
          nutrition!.minerals.manganese! * 1000000,
          unit: "µg",
          indented: true,
        ),
      if (nutrition?.minerals.molybdenum != null)
        NutritionRow(
          'Molybdenum',
          nutrition!.minerals.molybdenum! * 1000000,
          unit: "µg",
          indented: true,
        ),
      if (nutrition?.minerals.phosphorus != null)
        NutritionRow(
          'Phosphorus',
          nutrition!.minerals.phosphorus! * 1000,
          unit: "mg",
          indented: true,
        ),
      if (nutrition?.minerals.potassium != null)
        NutritionRow(
          'Potassium',
          nutrition!.minerals.potassium! * 1000,
          unit: "mg",
          indented: true,
        ),
      if (nutrition?.minerals.selenium != null)
        NutritionRow(
          'Selenium',
          nutrition!.minerals.selenium! * 1000000,
          unit: "µg",
          indented: true,
        ),
      if (nutrition?.minerals.sodium != null)
        NutritionRow(
          'Sodium',
          nutrition!.minerals.sodium! * 1000,
          unit: "mg",
          indented: true,
        ),
      if (nutrition?.minerals.zinc != null)
        NutritionRow(
          'Zinc',
          nutrition!.minerals.zinc! * 1000000,
          unit: "µg",
          indented: true,
        ),
    ];

    if (rows.isNotEmpty) {
      rows.insert(0, NutritionRow('Minerals', null, unit: null));
    }

    return rows;
  }

  List<NutritionRow> vitamins() {
    var rows = [
      if (nutrition?.vitamins.a != null)
        NutritionRow(
          'Vitamin A',
          nutrition!.vitamins.a! * 1000000,
          unit: "µg",
          indented: true,
        ),
      if (nutrition?.vitamins.b1 != null)
        NutritionRow(
          'Vitamin B1',
          nutrition!.vitamins.b1! * 1000,
          unit: "mg",
          indented: true,
        ),
      if (nutrition?.vitamins.b2 != null)
        NutritionRow(
          'Vitamin B2',
          nutrition!.vitamins.b2! * 1000,
          unit: "mg",
          indented: true,
        ),
      if (nutrition?.vitamins.b3 != null)
        NutritionRow(
          'Vitamin B3',
          nutrition!.vitamins.b3! * 1000,
          unit: "mg",
          indented: true,
        ),
      if (nutrition?.vitamins.b5 != null)
        NutritionRow(
          'Vitamin B5',
          nutrition!.vitamins.b5! * 1000,
          unit: "mg",
          indented: true,
        ),
      if (nutrition?.vitamins.b6 != null)
        NutritionRow(
          'Vitamin B6',
          nutrition!.vitamins.b6! * 1000,
          unit: "mg",
          indented: true,
        ),
      if (nutrition?.vitamins.b7 != null)
        NutritionRow(
          'Vitamin B7',
          nutrition!.vitamins.b7! * 1000000,
          unit: "µg",
          indented: true,
        ),
      if (nutrition?.vitamins.b9 != null)
        NutritionRow(
          'Vitamin B9',
          nutrition!.vitamins.b9! * 1000000,
          unit: "µg",
          indented: true,
        ),
      if (nutrition?.vitamins.b12 != null)
        NutritionRow(
          'Vitamin B12',
          nutrition!.vitamins.b12! * 1000000,
          unit: "µg",
          indented: true,
        ),
      if (nutrition?.vitamins.c != null)
        NutritionRow(
          'Vitamin C',
          nutrition!.vitamins.c! * 1000,
          unit: "mg",
          indented: true,
        ),
      if (nutrition?.vitamins.d != null)
        NutritionRow(
          'Vitamin D',
          nutrition!.vitamins.d! * 1000000,
          unit: "µg",
          indented: true,
        ),
      if (nutrition?.vitamins.e != null)
        NutritionRow(
          'Vitamin E',
          nutrition!.vitamins.e! * 1000,
          unit: "mg",
          indented: true,
        ),
      if (nutrition?.vitamins.k != null)
        NutritionRow(
          'Vitamin K',
          nutrition!.vitamins.k! * 1000000,
          unit: "µg",
          indented: true,
        ),
    ];

    if (rows.isNotEmpty) {
      rows.insert(0, NutritionRow('Vitamins', null, unit: null));
    }

    return rows;
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
