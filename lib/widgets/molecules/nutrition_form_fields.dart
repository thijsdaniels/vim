import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/widgets/atoms/standard_list.dart';

class NutritionFormFields extends StatelessWidget {
  final NutritionEditingController controller;
  final bool autofocus;
  final double spacing;

  const NutritionFormFields({
    super.key,
    required this.controller,
    this.autofocus = false,
    this.spacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    return StandardList(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        TextFormField(
          controller: controller.calories,
          autofocus: autofocus,
          decoration: const InputDecoration(
            labelText: 'Calories',
            hintText: 'kcal',
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a number.';
            }
            return null;
          },
        ),
        TextFormField(
          controller: controller.fats,
          decoration: const InputDecoration(
            labelText: 'Fats',
            hintText: 'g',
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a number.';
            }
            return null;
          },
        ),
        TextFormField(
          controller: controller.saturates,
          decoration: const InputDecoration(
            labelText: 'Saturated Fats',
            hintText: 'g',
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
          ],
        ),
        TextFormField(
          controller: controller.carbohydrates,
          decoration: const InputDecoration(
            labelText: 'Carbohydrates',
            hintText: 'g',
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a number.';
            }
            return null;
          },
        ),
        TextFormField(
          controller: controller.sugars,
          decoration: const InputDecoration(
            labelText: 'Sugars',
            hintText: 'g',
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
          ],
        ),
        TextFormField(
          controller: controller.fibers,
          decoration: const InputDecoration(
            labelText: 'Fibers',
            hintText: 'g',
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
          ],
        ),
        TextFormField(
          controller: controller.proteins,
          decoration: const InputDecoration(
            labelText: 'Proteins',
            hintText: 'g',
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a number.';
            }
            return null;
          },
        ),
        TextFormField(
          controller: controller.salt,
          decoration: const InputDecoration(
            labelText: 'Salt',
            hintText: 'g',
          ),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
          ],
        ),
        TextFormField(
          controller: controller.water,
          decoration: const InputDecoration(
            labelText: 'Water',
            hintText: 'g',
          ),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
          ],
        ),
        TextFormField(
          controller: controller.alcohol,
          decoration: const InputDecoration(
            labelText: 'Alcohol',
            hintText: '% vol.',
          ),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
          ],
        ),
        TextFormField(
          controller: controller.caffeine,
          decoration: const InputDecoration(
            labelText: 'Caffeine',
            hintText: 'mg',
          ),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
          ],
        ),
      ],
    );
  }
}

class NutritionEditingController {
  late final TextEditingController calories;
  late final TextEditingController fats;
  late final TextEditingController saturates;
  late final TextEditingController carbohydrates;
  late final TextEditingController sugars;
  late final TextEditingController fibers;
  late final TextEditingController proteins;
  late final TextEditingController salt;
  late final TextEditingController water;
  late final TextEditingController alcohol;
  late final TextEditingController caffeine;

  Nutrition get nutrition {
    return Nutrition(
      calories: double.parse(calories.value.text),
      fats: Fats(
        double.parse(fats.value.text),
        saturates: saturates.value.text.isNotEmpty
            ? double.parse(saturates.value.text)
            : null,
      ),
      carbohydrates: Carbohydrates(
        double.parse(carbohydrates.value.text),
        sugars: sugars.value.text.isNotEmpty
            ? double.parse(sugars.value.text)
            : null,
        fibers: fibers.value.text.isNotEmpty
            ? double.parse(fibers.value.text)
            : null,
      ),
      proteins: Proteins(
        double.parse(proteins.value.text),
      ),
      minerals: Minerals(
        sodium: salt.value.text.isNotEmpty
            ? Minerals.saltToSodium(double.parse(salt.value.text))
            : null,
      ),
      water:
          water.value.text.isNotEmpty ? double.parse(water.value.text) : null,
      alcohol: alcohol.value.text.isNotEmpty
          ? alcoholByWeight(double.parse(alcohol.value.text))
          : null,
      caffeine: caffeine.value.text.isNotEmpty
          ? double.parse(caffeine.value.text) / 1000
          : null,
    );
  }

  set nutrition(Nutrition nutrition) {
    calories.text = nutrition.calories.toString();
    carbohydrates.text = nutrition.carbohydrates.total?.toString() ?? "";
    fats.text = nutrition.fats.total?.toString() ?? "";
    proteins.text = nutrition.proteins.total?.toString() ?? "";
    saturates.text = nutrition.fats.saturates?.toString() ?? "";
    sugars.text = nutrition.carbohydrates.sugars?.toString() ?? "";
    fibers.text = nutrition.carbohydrates.fibers?.toString() ?? "";
    salt.text =
        Minerals.sodiumToSalt(nutrition.minerals.sodium)?.toString() ?? "";
    water.text = nutrition.water?.toString() ?? "";
    alcohol.text = alcoholByVolume(nutrition.alcohol)?.toString() ?? "";
    caffeine.text = nutrition.caffeine != null
        ? ((nutrition.caffeine ?? 0) * 1000).toString()
        : "";
  }

  NutritionEditingController({
    TextEditingController? calories,
    TextEditingController? fats,
    TextEditingController? saturates,
    TextEditingController? carbohydrates,
    TextEditingController? sugars,
    TextEditingController? fibers,
    TextEditingController? proteins,
    TextEditingController? salt,
    TextEditingController? water,
    TextEditingController? alcohol,
    TextEditingController? caffeine,
  }) {
    this.calories = calories ?? TextEditingController();
    this.fats = fats ?? TextEditingController();
    this.saturates = saturates ?? TextEditingController();
    this.carbohydrates = carbohydrates ?? TextEditingController();
    this.sugars = sugars ?? TextEditingController();
    this.fibers = fibers ?? TextEditingController();
    this.proteins = proteins ?? TextEditingController();
    this.salt = salt ?? TextEditingController();
    this.water = water ?? TextEditingController();
    this.alcohol = alcohol ?? TextEditingController();
    this.caffeine = caffeine ?? TextEditingController();
  }
}

double specificGravityOfAlcohol = 0.78924;

num? alcoholByWeight(num? alcoholByVolume) {
  return alcoholByVolume != null
      ? alcoholByVolume * specificGravityOfAlcohol
      : null;
}

num? alcoholByVolume(num? alcoholByWeight) {
  return alcoholByWeight != null
      ? alcoholByWeight / specificGravityOfAlcohol
      : null;
}
