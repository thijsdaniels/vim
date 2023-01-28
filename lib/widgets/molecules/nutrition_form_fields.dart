import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vim/models/nutrition.dart';

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
    return Column(
      children: [
        TextFormField(
          controller: controller.calories,
          autofocus: autofocus,
          decoration: const InputDecoration(
            labelText: 'Calories',
          ),
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
        SizedBox(height: spacing),
        TextFormField(
          controller: controller.fats,
          decoration: const InputDecoration(
            labelText: 'Fat',
          ),
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
        SizedBox(height: spacing),
        TextFormField(
          controller: controller.saturates,
          decoration: const InputDecoration(
            labelText: 'Saturated Fat',
          ),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
          ],
        ),
        SizedBox(height: spacing),
        TextFormField(
          controller: controller.carbohydrates,
          decoration: const InputDecoration(
            labelText: 'Carbs',
          ),
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
        SizedBox(height: spacing),
        TextFormField(
          controller: controller.sugars,
          decoration: const InputDecoration(
            labelText: 'Sugars',
          ),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
          ],
        ),
        SizedBox(height: spacing),
        TextFormField(
          controller: controller.fibers,
          decoration: const InputDecoration(
            labelText: 'Fiber',
          ),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
          ],
        ),
        SizedBox(height: spacing),
        TextFormField(
          controller: controller.proteins,
          decoration: const InputDecoration(
            labelText: 'Protein',
          ),
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
        SizedBox(height: spacing),
        TextFormField(
          controller: controller.salt,
          decoration: const InputDecoration(
            labelText: 'Salt',
          ),
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
        salt: salt.value.text.isNotEmpty ? double.parse(salt.value.text) : null,
      ),
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
    salt.text = nutrition.minerals.salt?.toString() ?? "";
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
  }) {
    this.calories = calories ?? TextEditingController();
    this.fats = fats ?? TextEditingController();
    this.saturates = saturates ?? TextEditingController();
    this.carbohydrates = carbohydrates ?? TextEditingController();
    this.sugars = sugars ?? TextEditingController();
    this.fibers = fibers ?? TextEditingController();
    this.proteins = proteins ?? TextEditingController();
    this.salt = salt ?? TextEditingController();
  }
}
