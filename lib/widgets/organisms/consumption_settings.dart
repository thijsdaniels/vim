import 'package:flutter/material.dart';
import 'package:vim/extensions/num.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/widgets/atoms/slider_form_field.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class ConsumptionSettings extends StatelessWidget {
  const ConsumptionSettings({
    super.key,
    required this.user,
    required this.onChanged,
  });

  final User user;
  final void Function(User user) onChanged;

  @override
  Widget build(BuildContext context) {
    // In grams of protein per kilograms of bodyweight.
    double maxProteins = ((1 - user.target.consumption.fats) *
        user.targetConsumption /
        Proteins.caloriesPerGram /
        user.body.weight.kilograms);

    // As a fraction of the total target calorie consumption.
    double maxFats = 1 - user.targetProteinConsumption;

    return SimpleCard(
      title: 'Consumption Target',
      child: StandardList(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          SliderFormField(
            label: const Text('Surplus'),
            valueLabel: '${(user.target.consumption.surplus * 100).round()}%',
            min: -0.2,
            max: 0.2,
            divisions: 8,
            value: user.target.consumption.surplus,
            onChanged: (value) {
              user.target.consumption.surplus = value.decimals(2);
              onChanged(user);
            },
          ),
          SliderFormField(
            label: const Text('Carbs'),
            valueLabel:
                '${(user.targetCarbohydrateConsumption * 100).round()}%',
            value: user.targetCarbohydrateConsumption,
          ),
          SliderFormField(
            label: const Text('Proteins'),
            valueLabel: '${(user.target.consumption.proteins).decimals(1)}g',
            value: user.target.consumption.proteins,
            min: 0,
            max: 3,
            divisions: 30,
            secondaryTrackValue: maxProteins.clamp(0, 3),
            onChanged: (value) {
              if (value < maxProteins) {
                user.target.consumption.proteins = value.decimals(1);
                onChanged(user);
              }
            },
          ),
          SliderFormField(
            label: const Text('Fats'),
            valueLabel: '${(user.target.consumption.fats * 100).round()}%',
            value: user.target.consumption.fats,
            divisions: 100,
            secondaryTrackValue: maxFats.clamp(0, 1),
            onChanged: (value) {
              if (value < maxFats) {
                user.target.consumption.fats = value.decimals(2);
                onChanged(user);
              }
            },
          ),
        ],
      ),
    );
  }
}
